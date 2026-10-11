local _, ns = ...
ns.locales = ns.locales or {}
ns.locales.koKR = {
    title = "Forever Exercise",
    notes = "틈틈이 짧은 책상 운동을 하라고 알려 줍니다. /fex",

    ready = "준비됐나요? %d초",
    start = "시작",
    done = "완료",
    another = "하나 더",
    snooze = "%d분 미루기",
    skip = "건너뛰기",
    wellDone = "잘했어요, 용사님!",
    secondsLeft = "%d초",
    combatChat = "전투를 먼저 끝내세요, 용사님.",

    exercising = "운동 중, %d초 남음",
    exerciseFinished = "운동 완료",
    exerciseReady = "운동 준비됨",
    paused = "%s 일시정지",
    pausedSnoozed = "%s 일시정지, 미뤄 둠",
    resumes = "재개되면 %s 남습니다",
    dueCombat = "지금은 할 차례지만, 전투가 끝나기를 기다립니다.",
    snoozedNext = "미뤄 둠, 다음 운동까지 %s",
    nextExercise = "다음 운동까지 %s",
    deathWaits = "사망 시 운동은 영혼을 놓아줄 때까지 기다립니다.",
    inRaid = "레이드에서",
    inDungeon = "던전에서",
    clickSettings = "클릭하면 설정이 열립니다. 드래그하면 이동합니다.",

    reminderInterval = "알림 간격",
    reminderIntervalTip = "운동 알림 사이의 플레이 시간(분)입니다.",
    minutes = "%d분",
    pauseInRaids = "레이드에서 일시정지",
    pauseInRaidsTip = "레이드 안에 있는 동안 타이머를 멈춥니다. 나가면 이어서 재개됩니다.",
    pauseInDungeons = "던전에서 일시정지",
    pauseInDungeonsTip = "던전 안에 있는 동안 타이머를 멈춥니다. 나가면 이어서 재개됩니다.",
    exerciseOnDeath = "사망 시 운동",
    exerciseOnDeathTip = "야외, 전장, 투기장에서 죽으면 운동을 보여 줍니다.",
    exerciseOnDungeonDeath = "던전 사망 시 운동",
    exerciseOnDungeonDeathTip = "던전에서 죽으면 운동을 보여 줍니다. 레이드는 별도 옵션입니다.",
    exerciseOnRaidDeath = "레이드 사망 시 운동",
    exerciseOnRaidDeathTip = "레이드에서 죽으면 운동을 보여 줍니다.",
    onlyGhost = "유령 상태일 때만",
    onlyGhostTip = "시체 상태에서는 보여 주지 않고, 영혼을 놓아줄 때까지 기다립니다.",

    exercises = {
        neck = {
            name = "목 기울이기",
            flavor = "그리핀도 착지 전에 양쪽을 살핍니다.",
            steps = {
                "허리를 펴고 앉아, 어깨의 힘을 빼고 정면을 보세요.",
                "한쪽 귀를 어깨 쪽으로 천천히 기울이고 5초간 유지하세요.",
                "가운데로 돌아온 뒤 반대쪽으로 기울이고 5초간 유지하세요.",
                "양쪽을 두 번씩 반복하세요. 억지로 늘리지 마세요.",
            },
        },
        shrugs = {
            name = "어깨 으쓱하기",
            flavor = "지난 와이프(wipe)는 어깨로 털어 버리세요.",
            steps = {
                "허리를 펴고 앉아 팔을 늘어뜨리세요.",
                "양쪽 어깨를 귀 쪽으로 끌어올리고 2초간 유지하세요.",
                "아래로, 살짝 뒤로 떨어뜨리며 숨을 내쉬세요.",
                "10회 반복하세요.",
            },
        },
        sideStretch = {
            name = "머리 위 옆구리 스트레칭",
            flavor = "루트(loot)가 막 떨어진 듯 손을 뻗으세요.",
            steps = {
                "허리를 펴고 앉아 손바닥을 맞대고 양팔을 머리 위로 뻗으세요.",
                "옆구리가 당겨질 때까지 한쪽으로 천천히 기울이고 5초간 유지하세요.",
                "가운데로 돌아온 뒤 반대쪽으로 기울이고 5초간 유지하세요.",
                "엉덩이는 의자에 붙인 채 두 번 반복하세요.",
            },
        },
        chestOpener = {
            name = "가슴 열기",
            flavor = "당당히 서세요, 용사님. 아제로스가 보고 있습니다.",
            steps = {
                "일어나 발을 골반 너비로 벌리세요.",
                "등 뒤에서 손가락을 깍지 끼세요.",
                "팔을 펴고 어깨뼈를 모으며 가슴을 들고 15초간 유지하세요.",
                "풀고 어깨를 돌린 뒤 한 번 더 하세요.",
            },
        },
        legExtensions = {
            name = "앉아서 다리 펴기",
            flavor = "다리가 너무 오래 AFK입니다.",
            steps = {
                "의자 앞쪽에 허리를 펴고 앉아 양손을 허벅지에 올리세요.",
                "한쪽 다리를 수평으로 펴고 발끝을 당긴 채 3초간 유지하세요.",
                "천천히 내린 다음 반대쪽 다리를 드세요.",
                "30초 동안 번갈아 계속하세요.",
            },
        },
        chairSquats = {
            name = "의자 스쿼트",
            flavor = "일어서세요, 용사님! 의자는 기다려도 됩니다.",
            steps = {
                "의자 앞쪽에 앉아 발바닥을 붙이고 골반 너비로 벌리세요.",
                "팔을 앞으로 뻗고 가슴을 무릎 위로 숙이세요.",
                "발뒤꿈치로 밀며 허리를 펴고 일어서세요.",
                "천천히 다시 앉으세요. 8~10회 반복하세요.",
            },
        },
        calfRaises = {
            name = "종아리 들기",
            flavor = "정예 옆을 살금살금 지나듯 까치발을 하세요.",
            steps = {
                "책상 앞에 서서 손끝을 책상에 살짝 올리세요.",
                "발볼로 올라서세요.",
                "가장 높이 올린 채 2초간 유지하세요.",
                "천천히 내리고 15회 반복하세요.",
            },
        },
        march = {
            name = "제자리 행진",
            flavor = "레이드에 늦은 것처럼 행진하세요.",
            steps = {
                "책상 옆에 허리를 펴고 서세요.",
                "한쪽 무릎을 골반 높이로 들고 반대쪽 팔을 앞으로 흔드세요.",
                "내린 뒤 반대쪽 무릎을 드세요.",
                "30초 동안 일정한 빠른 리듬을 유지하세요.",
            },
        },
    },
}
