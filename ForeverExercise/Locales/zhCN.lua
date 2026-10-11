local _, ns = ...
ns.locales = ns.locales or {}
ns.locales.zhCN = {
    title = "Forever Exercise",
    notes = "每隔一段时间提醒你做一段短暂的桌前运动。/fex",

    ready = "准备好了吗？%d 秒",
    start = "开始",
    done = "完成",
    another = "再来",
    snooze = "延后 %d 分",
    skip = "跳过",
    wellDone = "做得好，勇士！",
    secondsLeft = "%d秒",
    combatChat = "先打完这场，勇士。",

    exercising = "运动中，还剩 %d 秒",
    exerciseFinished = "运动结束",
    exerciseReady = "可以运动了",
    paused = "暂停%s",
    pausedSnoozed = "暂停%s，已延后",
    resumes = "恢复时还剩 %s",
    dueCombat = "时间到了，正在等战斗结束",
    snoozedNext = "已延后，下次运动还有 %s",
    nextExercise = "下次运动还有 %s",
    deathWaits = "死亡运动要等到你释放灵魂",
    inRaid = "在raid中",
    inDungeon = "在地下城中",
    clickSettings = "点击打开设置。拖动即可移动。",

    reminderInterval = "提醒间隔",
    reminderIntervalTip = "两次运动提醒之间相隔的游戏分钟数。",
    minutes = "%d 分钟",
    pauseInRaids = "raid中暂停",
    pauseInRaidsTip = "在raid中停止计时。离开后会恢复。",
    pauseInDungeons = "地下城中暂停",
    pauseInDungeonsTip = "在地下城中停止计时。离开后会恢复。",
    exerciseOnDeath = "死亡时运动",
    exerciseOnDeathTip = "在世界、战场或竞技场中死亡时显示运动。",
    exerciseOnDungeonDeath = "地下城死亡时运动",
    exerciseOnDungeonDeathTip = "在地下城中死亡时显示运动。raid有自己的选项。",
    exerciseOnRaidDeath = "raid死亡时运动",
    exerciseOnRaidDeathTip = "在raid中死亡时显示运动。",
    onlyGhost = "只在鬼魂状态下",
    onlyGhostTip = "等到你释放灵魂后再显示，而不是在尸体上就出现。",

    exercises = {
        neck = {
            name = "颈部侧倾",
            flavor = "就连狮鹫也会在降落前左右看看。",
            steps = {
                "坐直，双肩放松，目视前方。",
                "慢慢把一侧耳朵靠向肩膀，保持 5 秒。",
                "回到正中，再靠向另一侧，保持 5 秒。",
                "两侧各做两次。不要勉强拉伸。",
            },
        },
        shrugs = {
            name = "耸肩",
            flavor = "把上次wipe耸掉吧。",
            steps = {
                "坐直，双臂自然下垂。",
                "把双肩向上提到耳边，保持 2 秒。",
                "让双肩落下并微微向后，同时呼气。",
                "重复 10 次。",
            },
        },
        sideStretch = {
            name = "举臂侧拉伸",
            flavor = "伸手去够刚掉下来的loot。",
            steps = {
                "坐直，双臂举过头顶，掌心相合。",
                "慢慢侧弯，直到感到拉伸，保持 5 秒。",
                "回到正中，再弯向另一侧，保持 5 秒。",
                "臀部贴住座位。重复两次。",
            },
        },
        chestOpener = {
            name = "扩胸",
            flavor = "挺起胸膛，勇士。艾泽拉斯正看着你。",
            steps = {
                "站起来，双脚与髋部同宽。",
                "双手在背后十指交扣。",
                "伸直手臂，夹紧肩胛骨并挺胸，保持 15 秒。",
                "松开，双肩绕环，再做一次。",
            },
        },
        legExtensions = {
            name = "坐姿伸腿",
            flavor = "双腿AFK够久了。",
            steps = {
                "坐在椅子前缘，上身坐直，双手放在大腿上。",
                "一条腿伸至水平，脚尖勾向自己，保持 3 秒。",
                "慢慢放下，再抬起另一条腿。",
                "在整整 30 秒内交替进行。",
            },
        },
        chairSquats = {
            name = "椅子深蹲",
            flavor = "起身吧，勇士！椅子可以等。",
            steps = {
                "坐在椅子前缘，双脚踩平，与髋部同宽。",
                "双臂向前伸，胸口前倾越过膝盖。",
                "用脚跟发力，站直身体。",
                "慢慢坐回去。重复 8 到 10 次。",
            },
        },
        calfRaises = {
            name = "小腿提踵",
            flavor = "踮起脚尖，像要溜过精英。",
            steps = {
                "站在桌前，指尖轻放在桌上。",
                "踮起脚，重心移到前脚掌。",
                "在最高点保持 2 秒。",
                "慢慢放下。重复 15 次。",
            },
        },
        march = {
            name = "原地踏步",
            flavor = "踏步吧，像是快赶不上raid了。",
            steps = {
                "在桌旁站直。",
                "一膝抬到髋部高度，对侧手臂向前摆。",
                "放下，再抬起另一膝。",
                "以稳定轻快的节奏持续 30 秒。",
            },
        },
    },
}
