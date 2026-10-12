local ADDON, ns = ...

local function ApplyLocale()
    local code = GetLocale()
    if code == "enGB" then code = "enUS" end
    -- English itself is the fallback, so it must not index itself.
    ns.L = setmetatable(code ~= "enUS" and ns.locales[code] or {}, { __index = ns.locales.enUS })
    for _, exercise in ipairs(ns.exercises) do
        local translated = ns.L.exercises[exercise.id]
        if translated then
            exercise.name = translated.name
            exercise.flavor = translated.flavor
            exercise.steps = translated.steps
        end
    end
end
ApplyLocale()

local L = ns.L
local S = ns.style
local DOT = "Interface\\CHARACTERFRAME\\TempPortraitAlphaMask"
local ICON = "Interface\\Icons\\INV_Misc_PocketWatch_01"
local PREFIX = "|cffffd100" .. L.title .. ":|r "

local db, category
local frame, big, stepsText, bar, barText, startButton
local thumbs = {}
local ex                  -- exercise on screen
local remaining           -- countdown seconds, nil when not running
local elapsed = 0         -- seconds counted toward the next reminder
local snoozed = false
local waitForGhost = false
local combatHide = false  -- hidden by combat: the reminder stays due
local minimapButton
local syncAfter
local OfferSync

for _, e in ipairs(ns.exercises) do
    e.frames = {}
    for i, override in ipairs(e.poses) do
        local pose = {}
        for joint, p in pairs(ns.poses[e.base]) do pose[joint] = p end
        for joint, p in pairs(override) do pose[joint] = p end
        e.frames[i] = pose
    end
end

-- Pictogram ------------------------------------------------------------------

local function IsFar(joint)
    return joint:sub(1, 1) == "l"
end

local function Ink(e, joint)
    return e.side and IsFar(joint) and S.far or S.ink
end

local function Anchor(line, f, x1, y1, x2, y2)
    line:SetStartPoint("BOTTOMLEFT", f, x1 * f.u, y1 * f.u)
    line:SetEndPoint("BOTTOMLEFT", f, x2 * f.u, y2 * f.u)
end

local function CreateFigure(parent, size)
    local f = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    f:SetSize(size, size)
    f:SetBackdrop({ edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 12 })
    f:SetBackdropBorderColor(0.8, 0.65, 0.35)
    local bg = f:CreateTexture(nil, "BACKGROUND", nil, -8)
    bg:SetPoint("TOPLEFT", 3, -3)
    bg:SetPoint("BOTTOMRIGHT", -3, 3)
    bg:SetTexture("Interface\\QuestFrame\\QuestBG")
    bg:SetVertexColor(1, 0.96, 0.84)

    f.u = size / 100
    f.bones, f.dots, f.props, f.pose = {}, {}, {}, {}
    local width = S.thickness * f.u
    for i, bone in ipairs(ns.bones) do
        local line = f:CreateLine(nil, "ARTWORK", nil, IsFar(bone[2]) and 1 or 3)
        line:SetThickness(width)
        f.bones[i] = line
        -- dots round off the joints, the head is a big one
        for _, joint in ipairs(bone) do
            if not f.dots[joint] then
                local dot = f:CreateTexture(nil, "ARTWORK", nil, joint == "head" and 4 or IsFar(joint) and 1 or 3)
                dot:SetTexture(DOT)
                local d = joint == "head" and S.headRadius * 2 * f.u or width
                dot:SetSize(d, d)
                f.dots[joint] = dot
            end
        end
    end
    return f
end

local function SetFigureExercise(f, e)
    for i, bone in ipairs(ns.bones) do
        f.bones[i]:SetColorTexture(unpack(Ink(e, bone[2])))
    end
    for joint, dot in pairs(f.dots) do
        dot:SetVertexColor(unpack(Ink(e, joint)))
    end
    local n = 0
    for _, name in ipairs(e.props) do
        for _, seg in ipairs(ns.props[name]) do
            n = n + 1
            local line = f.props[n]
            if not line then
                line = f:CreateLine(nil, "ARTWORK", nil, 0)
                line:SetThickness(S.propThickness * f.u)
                line:SetColorTexture(unpack(S.prop))
                f.props[n] = line
            end
            Anchor(line, f, seg[1], seg[2], seg[3], seg[4])
            line:Show()
        end
    end
    for i = n + 1, #f.props do
        f.props[i]:Hide()
    end
end

local function Place(f, pose)
    for i, bone in ipairs(ns.bones) do
        local a, b = pose[bone[1]], pose[bone[2]]
        Anchor(f.bones[i], f, a[1], a[2], b[1], b[2])
    end
    for joint, dot in pairs(f.dots) do
        local p = pose[joint]
        dot:SetPoint("CENTER", f, "BOTTOMLEFT", p[1] * f.u, p[2] * f.u)
    end
end

local function Blend(f, a, b, t)
    for joint, p in pairs(a) do
        local q = b[joint]
        local o = f.pose[joint] or {}
        o[1], o[2] = p[1] + (q[1] - p[1]) * t, p[2] + (q[2] - p[2]) * t
        f.pose[joint] = o
    end
    Place(f, f.pose)
end

local function Animate(self, dt)
    self.t = self.t + dt
    local n, step = #ex.frames, self.t / ex.tempo
    local i = math.floor(step) % n + 1
    local t = math.min(1, math.max(0, (step % 1 - S.hold) / (1 - S.hold)))
    Blend(self, ex.frames[i], ex.frames[i % n + 1], t * t * (3 - 2 * t))
    for k, thumb in ipairs(thumbs) do
        thumb:SetAlpha(k == i and 1 or 0.55)
    end
end

-- Popup ----------------------------------------------------------------------

local function Sound(kit)
    if kit then PlaySound(kit) end
end

local function SetIdle()
    remaining = nil
    bar:SetValue(0)
    barText:SetText(L.ready:format(ns.timing.duration))
    startButton:SetText(L.start)
    startButton:Enable()
end

local function Render()
    frame.Name:SetText(ex.name)
    frame.Flavor:SetText(ex.flavor)
    local lines = {}
    for i, step in ipairs(ex.steps) do
        lines[i] = ("|cffffd100%d.|r %s"):format(i, step)
    end
    stepsText:SetText(table.concat(lines, "\n\n"))
    SetFigureExercise(big, ex)
    big.t = 0
    for i, thumb in ipairs(thumbs) do
        local pose = ex.frames[i]
        thumb:SetShown(pose ~= nil)
        if pose then
            SetFigureExercise(thumb, ex)
            Place(thumb, pose)
        end
    end
    SetIdle()
end

-- One shuffled deck, like an iPod: every exercise plays once before any repeats.
-- A fresh deck never opens with the exercise that just played. Mirrored in browser/index.html.
local deck = {}

local function Shuffle(list)
    for i = #list, 2, -1 do
        local j = math.random(i)
        list[i], list[j] = list[j], list[i]
    end
end

local function PickExercise()
    if #deck == 0 then
        for _, exercise in ipairs(ns.exercises) do
            deck[#deck + 1] = exercise
        end
        Shuffle(deck)
        if deck[1] == ex and #deck > 1 then
            local j = math.random(2, #deck)
            deck[1], deck[j] = deck[j], deck[1]
        end
    end
    ex = table.remove(deck, 1)
end

local function ShowReminder()
    snoozed = false
    PickExercise()
    Render()
    frame:Show()
    Sound(SOUNDKIT.READY_CHECK)
end

local function Countdown(_, dt)
    if not remaining then return end
    remaining = remaining - dt
    if remaining > 0 then
        bar:SetValue(ns.timing.duration - remaining)
        barText:SetText(L.secondsLeft:format(math.ceil(remaining)))
        return
    end
    remaining = nil
    elapsed = 0
    bar:SetValue(ns.timing.duration)
    barText:SetText(L.wellDone)
    startButton:SetText(L.done)
    startButton:Enable()
    Sound(SOUNDKIT.IG_QUEST_LIST_COMPLETE)
end

local function Button(text, width, onClick)
    local b = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    b:SetSize(width, 22)
    b:SetText(text)
    b:SetScript("OnClick", onClick)
    return b
end

local function Build()
    frame = CreateFrame("Frame", "ForeverExerciseFrame", UIParent, "ButtonFrameTemplate")
    frame:SetSize(470, 380)
    frame:SetPoint("CENTER", 0, 80)
    frame:SetFrameStrata("DIALOG")
    frame:SetClampedToScreen(true)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    frame:SetTitle(L.title)
    if frame.SetPortraitToAsset then
        frame:SetPortraitToAsset(ICON)
    else
        ButtonFrameTemplate_HidePortrait(frame)
    end
    frame:Hide()
    tinsert(UISpecialFrames, frame:GetName())

    frame.Name = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    frame.Name:SetPoint("TOPLEFT", 66, -29)
    frame.Flavor = frame:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall")
    frame.Flavor:SetPoint("TOPLEFT", frame.Name, "BOTTOMLEFT", 0, -3)

    local inset = frame.Inset
    big = CreateFigure(inset, 180)
    big:SetPoint("TOPLEFT", 8, -8)
    big:SetScript("OnUpdate", Animate)

    stepsText = inset:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    stepsText:SetPoint("TOPLEFT", big, "TOPRIGHT", 12, -4)
    stepsText:SetPoint("RIGHT", -10, 0)
    stepsText:SetJustifyH("LEFT")
    stepsText:SetJustifyV("TOP")

    local count = 0
    for _, e in ipairs(ns.exercises) do
        count = math.max(count, #e.frames)
    end
    for i = 1, count do
        local thumb = CreateFigure(inset, 60)
        thumb:SetPoint("TOPLEFT", big, "BOTTOMLEFT", (i - 1) * 68, -8)
        local label = thumb:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        label:SetPoint("TOPLEFT", 6, -5)
        label:SetTextColor(unpack(S.ink))
        label:SetText(i)
        thumbs[i] = thumb
    end

    bar = CreateFrame("StatusBar", nil, inset)
    bar:SetPoint("BOTTOMLEFT", 8, 8)
    bar:SetPoint("BOTTOMRIGHT", -8, 8)
    bar:SetHeight(16)
    bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    bar:SetStatusBarColor(1, 0.82, 0)
    bar:SetMinMaxValues(0, ns.timing.duration)
    local barBg = bar:CreateTexture(nil, "BACKGROUND")
    barBg:SetAllPoints()
    barBg:SetColorTexture(0, 0, 0, 0.6)
    barText = bar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    barText:SetPoint("CENTER")
    bar:SetScript("OnUpdate", Countdown)

    startButton = Button(L.start, 108, function()
        if bar:GetValue() >= ns.timing.duration then
            frame:Hide()
        else
            remaining = ns.timing.duration
            startButton:Disable()
        end
    end)
    startButton:SetPoint("BOTTOMLEFT", 6, 4)
    local another = Button(L.another, 108, function()
        PickExercise()
        Render()
    end)
    another:SetPoint("LEFT", startButton, "RIGHT", 4, 0)
    local snooze = Button(L.snooze:format(ns.timing.snooze), 108, function()
        frame:Hide() -- OnHide clears the timer; the snooze is what replaces it
        elapsed = db.interval * 60 - ns.timing.snooze * 60
        snoozed = true
    end)
    snooze:SetPoint("LEFT", another, "RIGHT", 4, 0)
    local skip = Button(L.skip, 108, function()
        frame:Hide()
    end)
    skip:SetPoint("LEFT", snooze, "RIGHT", 4, 0)

    -- Closing in any way (X, Escape, Skip, Done) restarts the timer
    frame:SetScript("OnHide", function()
        if not combatHide then
            elapsed = 0
            snoozed = false
        end
        combatHide = false
        remaining = nil
        if syncAfter then
            local seconds = syncAfter
            syncAfter = nil
            OfferSync(seconds)
        end
    end)
end

-- Timer, settings, slash command ---------------------------------------------

local function Clock(seconds)
    seconds = math.max(0, math.ceil(seconds))
    return ("%d:%02d"):format(math.floor(seconds / 60), seconds % 60)
end

-- "party" is a dungeon. Battlegrounds and arenas still open the window.
local function HoldKind()
    local _, kind = IsInInstance()
    if kind == "raid" and db.pauseInRaid then return "raid" end
    if kind == "party" and db.pauseInDungeon then return "dungeon" end
end

-- Same sentences as statusLines in browser/luadata.js, through L.
local function TooltipLines()
    if frame:IsShown() then
        if remaining then
            return { L.exercising:format(math.ceil(remaining)) }
        elseif bar:GetValue() >= ns.timing.duration then
            return { L.exerciseFinished }
        end
        return { L.exerciseReady }
    end
    local left = math.max(0, db.interval * 60 - elapsed)
    local hold = HoldKind()
    if hold and elapsed >= db.interval * 60 then
        return { hold == "raid" and L.dueLeaveRaid or L.dueLeaveDungeon }
    end
    if elapsed >= db.interval * 60 and InCombatLockdown() then
        return { L.dueCombat }
    end
    local lines = { snoozed and L.snoozedNext:format(Clock(left)) or L.nextExercise:format(Clock(left)) }
    if hold then
        lines[#lines + 1] = L.windowWaits
    end
    if waitForGhost then
        lines[#lines + 1] = L.deathWaits
    end
    return lines
end

local function RefreshTooltip()
    if not minimapButton or not minimapButton:IsMouseOver() then return end
    if GameTooltip:GetOwner() ~= minimapButton then
        GameTooltip:SetOwner(minimapButton, "ANCHOR_LEFT")
    end
    GameTooltip:ClearLines()
    GameTooltip:SetText(L.title, 1, 0.82, 0)
    for _, line in ipairs(TooltipLines()) do
        GameTooltip:AddLine(line, 1, 1, 1, true)
    end
    GameTooltip:AddLine(L.clickSettings, 0.6, 0.6, 0.6)
    GameTooltip:Show()
end

local function Tick()
    RefreshTooltip()
    if frame:IsShown() then return end
    elapsed = elapsed + 1
    if HoldKind() then return end
    if elapsed >= db.interval * 60 and not InCombatLockdown() then
        ShowReminder()
    end
end

-- Group sync uses addon messages only, so players without this addon see nothing.
-- The joiner copies the leader's remaining time, or the soonest reply when the
-- leader has no addon. Mirrors groupTimer in browser/luadata.js.
local ADDON_PREFIX = "ForeverExercise"
local askedThisGroup = false
local syncSerial = 0
local collecting = false
local leaderLeft, soonestLeft

local function SecondsLeft()
    return math.max(0, math.ceil(db.interval * 60 - elapsed))
end

local function SendAddon(message, channel, target)
    local send = C_ChatInfo and C_ChatInfo.SendAddonMessage or SendAddonMessage
    if send then pcall(send, ADDON_PREFIX, message, channel, target) end
end

local function GroupChannel()
    if LE_PARTY_CATEGORY_INSTANCE and IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
        return "INSTANCE_CHAT"
    end
    if IsInRaid() then return "RAID" end
    if IsInGroup() then return "PARTY" end
end

OfferSync = function(seconds)
    local left = math.max(0, db.interval * 60 - elapsed)
    if math.abs(left - seconds) < 1 then return end
    if frame:IsShown() then
        syncAfter = seconds
        return
    end
    StaticPopup_Show("FOREVER_EXERCISE_SYNC", L.syncAsk:format(Clock(seconds)), nil, seconds)
end

StaticPopupDialogs.FOREVER_EXERCISE_SYNC = {
    text = "%s",
    button1 = YES,
    button2 = NO,
    OnAccept = function(_, seconds)
        elapsed = db.interval * 60 - seconds
        snoozed = false
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

local function OnAddon(prefix, message, _, sender)
    if prefix ~= ADDON_PREFIX or not db.syncTimers or not sender then return end
    if Ambiguate(sender, "short") == Ambiguate(UnitName("player"), "short") then return end
    if message == "q" then
        if IsInGroup() then SendAddon(("a:%d"):format(SecondsLeft()), "WHISPER", sender) end
        return
    end
    local seconds = tonumber(message:match("^a:(%d+)$"))
    -- ponytail: replies above the settings max (120 min) are ignored
    if not seconds or seconds > 120 * 60 or not collecting then return end
    if UnitIsGroupLeader(sender) then
        leaderLeft = seconds
    elseif not soonestLeft or seconds < soonestLeft then
        soonestLeft = seconds
    end
end

local function BeginAsk()
    if askedThisGroup or not db.syncTimers or not IsInGroup() or UnitIsGroupLeader("player") then return end
    local channel = GroupChannel()
    if not channel then return end
    askedThisGroup = true
    syncSerial = syncSerial + 1
    local serial = syncSerial
    collecting = true
    leaderLeft, soonestLeft = nil, nil
    SendAddon("q", channel)
    C_Timer.After(2, function()
        if serial ~= syncSerial then return end
        collecting = false
        local pick = leaderLeft or soonestLeft
        leaderLeft, soonestLeft = nil, nil
        if pick and IsInGroup() and db.syncTimers then OfferSync(pick) end
    end)
end

local function OnRoster()
    if not IsInGroup() then
        askedThisGroup = false
        syncSerial = syncSerial + 1
        collecting = false
        leaderLeft, soonestLeft = nil, nil
        return
    end
    BeginAsk()
end

local function Checkbox(key, name, tooltip)
    local setting = Settings.RegisterAddOnSetting(category, "ForeverExercise_" .. key, key, db,
        Settings.VarType.Boolean, name, ns.defaults[key])
    return setting, Settings.CreateCheckbox(category, setting, tooltip)
end

-- The ghost line sits under its death option and is greyed out while that option is off.
local function DeathOption(key, name, tooltip)
    local setting, init = Checkbox(key, name, tooltip)
    local _, ghost = Checkbox(key .. "Ghost", L.onlyGhost, L.onlyGhostTip)
    ghost:SetParentInitializer(init, function() return setting:GetValue() end)
end

local function RegisterSettings()
    category = Settings.RegisterVerticalLayoutCategory(L.title)
    local interval = Settings.RegisterAddOnSetting(category, "ForeverExercise_interval", "interval", db,
        Settings.VarType.Number, L.reminderInterval, ns.defaults.interval)
    local options = Settings.CreateSliderOptions(5, 120, 5)
    options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, function(value)
        return L.minutes:format(value)
    end)
    Settings.CreateSlider(category, interval, options, L.reminderIntervalTip)
    Checkbox("pauseInRaid", L.pauseInRaids, L.pauseInRaidsTip)
    Checkbox("pauseInDungeon", L.pauseInDungeons, L.pauseInDungeonsTip)
    Checkbox("syncTimers", L.syncTimers, L.syncTimersTip)
    DeathOption("exerciseOnDeath", L.exerciseOnDeath, L.exerciseOnDeathTip)
    DeathOption("exerciseOnDungeonDeath", L.exerciseOnDungeonDeath, L.exerciseOnDungeonDeathTip)
    DeathOption("exerciseOnRaidDeath", L.exerciseOnRaidDeath, L.exerciseOnRaidDeathTip)
    Settings.RegisterAddOnCategory(category)
end

-- Releasing spirit in a dungeon puts the ghost outside it, so the place is
-- taken at the death and not read again. Mirrors deathReaction in browser/luadata.js.
local DEATH_KEYS = {
    world = "exerciseOnDeath",
    party = "exerciseOnDungeonDeath",
    raid = "exerciseOnRaidDeath",
}

local function OnDeath()
    local _, kind = IsInInstance()
    local key = DEATH_KEYS[kind] or DEATH_KEYS.world
    waitForGhost = db[key] and db[key .. "Ghost"] or false
    if db[key] and not db[key .. "Ghost"] then
        ShowReminder()
    end
end

local function OnReleased()
    if waitForGhost and UnitIsGhost("player") then
        ShowReminder()
    end
    waitForGhost = false
end

-- A round button on the minimap rim, using the client's tracking-button border.
-- Same layout as ForeverVO, which was measured on this client.
local function CreateMinimapButton()
    local button = CreateFrame("Button", "ForeverExerciseMinimapButton", Minimap)
    minimapButton = button
    button:SetSize(32, 32)
    button:SetFrameStrata("MEDIUM")
    button:SetFrameLevel(8)
    button:RegisterForClicks("LeftButtonUp")
    button:RegisterForDrag("LeftButton")
    button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

    local overlay = button:CreateTexture(nil, "OVERLAY")
    overlay:SetSize(53, 53)
    overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
    overlay:SetPoint("TOPLEFT")

    local background = button:CreateTexture(nil, "BACKGROUND")
    background:SetSize(20, 20)
    background:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
    background:SetPoint("TOPLEFT", 7, -5)

    local icon = button:CreateTexture(nil, "ARTWORK")
    icon:SetSize(17, 17)
    icon:SetTexture(ICON)
    icon:SetPoint("CENTER", background, "CENTER", -0.75, -0.5)

    local function UpdatePosition()
        local angle = math.rad(db.minimapAngle)
        local radius = Minimap:GetWidth() / 2 + 6
        button:ClearAllPoints()
        button:SetPoint("CENTER", Minimap, "CENTER", math.cos(angle) * radius, math.sin(angle) * radius)
    end

    button:SetScript("OnClick", function()
        Settings.OpenToCategory(category:GetID())
    end)
    button:SetScript("OnDragStart", function(self)
        self:SetScript("OnUpdate", function()
            local mx, my = Minimap:GetCenter()
            local cx, cy = GetCursorPosition()
            local scale = Minimap:GetEffectiveScale()
            db.minimapAngle = math.deg(math.atan2(cy / scale - my, cx / scale - mx))
            UpdatePosition()
        end)
    end)
    button:SetScript("OnDragStop", function(self)
        self:SetScript("OnUpdate", nil)
    end)
    button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        RefreshTooltip()
    end)
    button:SetScript("OnLeave", GameTooltip_Hide)
    UpdatePosition()
end

SLASH_FOREVEREXERCISE1 = "/fex"
SLASH_FOREVEREXERCISE2 = "/exercise"
SlashCmdList.FOREVEREXERCISE = function(msg)
    msg = msg:lower()
    if msg:match("^opt") or msg:match("^config") then
        Settings.OpenToCategory(category:GetID())
    elseif InCombatLockdown() then
        print(PREFIX .. L.combatChat)
    else
        ShowReminder()
    end
end

local events = CreateFrame("Frame")
events:RegisterEvent("ADDON_LOADED")
events:RegisterEvent("PLAYER_REGEN_DISABLED")
events:SetScript("OnEvent", function(_, event, ...)
    if event == "PLAYER_REGEN_DISABLED" then
        if frame and frame:IsShown() then
            combatHide = true
            -- An unfinished popup is due again when combat ends. A finished one stays closed.
            if bar:GetValue() < ns.timing.duration then elapsed = math.max(elapsed, db.interval * 60) end
            frame:Hide()
        end
    elseif event == "PLAYER_DEAD" then
        OnDeath()
    elseif event == "PLAYER_ALIVE" then
        OnReleased()
    elseif event == "CHAT_MSG_ADDON" then
        OnAddon(...)
    elseif event == "GROUP_ROSTER_UPDATE" or event == "PLAYER_ENTERING_WORLD" then
        OnRoster()
    elseif event == "ADDON_LOADED" and ... == ADDON then
        ForeverExerciseDB = ForeverExerciseDB or {}
        db = ForeverExerciseDB
        for key, value in pairs(ns.defaults) do
            if db[key] == nil then db[key] = value end
        end
        Build()
        RegisterSettings()
        CreateMinimapButton()
        local register = C_ChatInfo and C_ChatInfo.RegisterAddonMessagePrefix or RegisterAddonMessagePrefix
        if register then pcall(register, ADDON_PREFIX) end
        events:RegisterEvent("PLAYER_DEAD")
        events:RegisterEvent("PLAYER_ALIVE")
        events:RegisterEvent("GROUP_ROSTER_UPDATE")
        events:RegisterEvent("PLAYER_ENTERING_WORLD")
        events:RegisterEvent("CHAT_MSG_ADDON")
        C_Timer.NewTicker(1, Tick)
        OnRoster()
    end
end)
