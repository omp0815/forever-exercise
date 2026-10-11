local _, ns = ...

ns.locales = ns.locales or {}

-- English is the fallback. Other files set ns.locales.<GetLocale() code>.
-- enGB uses this table. Keep %d and %s in the same order in every language.
ns.locales.enUS = {
    title = "Forever Exercise",
    ready = "Ready? %d seconds",
    start = "Start",
    done = "Done",
    another = "Another",
    snooze = "Snooze %d min",
    skip = "Skip",
    wellDone = "Well done, champion!",
    secondsLeft = "%ds",
    combatChat = "finish the fight first, champion.",

    exercising = "Exercising, %ds left",
    exerciseFinished = "Exercise finished",
    exerciseReady = "Exercise ready",
    paused = "Paused %s",
    pausedSnoozed = "Paused %s, snoozed",
    resumes = "Resumes with %s left",
    dueCombat = "Due now, waiting for combat to end",
    snoozedNext = "Snoozed, next exercise in %s",
    nextExercise = "Next exercise in %s",
    deathWaits = "Death exercise waits until you release your spirit",
    inRaid = "in a raid",
    inDungeon = "in a dungeon",
    clickSettings = "Click to open settings. Drag to move.",

    reminderInterval = "Reminder interval",
    reminderIntervalTip = "Minutes of play between exercise reminders.",
    minutes = "%d min",
    pauseInRaids = "Pause in raids",
    pauseInRaidsTip = "Stop the timer while you are inside a raid. It resumes when you leave.",
    pauseInDungeons = "Pause in dungeons",
    pauseInDungeonsTip = "Stop the timer while you are inside a dungeon. It resumes when you leave.",
    exerciseOnDeath = "Exercise when you die",
    exerciseOnDeathTip = "Show an exercise when you die in the world, a battleground or an arena.",
    exerciseOnDungeonDeath = "Exercise when you die in a dungeon",
    exerciseOnDungeonDeathTip = "Show an exercise when you die in a dungeon. Raids have their own option.",
    exerciseOnRaidDeath = "Exercise when you die in a raid",
    exerciseOnRaidDeathTip = "Show an exercise when you die in a raid.",
    onlyGhost = "Only while you are a ghost",
    onlyGhostTip = "Wait until you release your spirit, instead of showing the exercise on the corpse.",

    exercises = {
        neck = {
            name = "Neck Tilts",
            flavor = "Even a gryphon looks both ways before landing.",
            steps = {
                "Sit tall, shoulders relaxed, eyes forward.",
                "Slowly tilt one ear toward your shoulder. Hold 5 seconds.",
                "Return to center, then tilt to the other side. Hold 5 seconds.",
                "Repeat each side twice. Never force the stretch.",
            },
        },
        shrugs = {
            name = "Shoulder Shrugs",
            flavor = "Shrug off that last wipe.",
            steps = {
                "Sit tall and let your arms hang loose.",
                "Pull both shoulders up toward your ears. Hold 2 seconds.",
                "Let them drop down and slightly back. Breathe out.",
                "Repeat 10 times.",
            },
        },
        sideStretch = {
            name = "Overhead Side Stretch",
            flavor = "Reach as if the loot just dropped.",
            steps = {
                "Sit tall and reach both arms overhead, palms together.",
                "Lean slowly to one side until you feel the stretch. Hold 5 seconds.",
                "Come back to center, then lean to the other side. Hold 5 seconds.",
                "Keep your hips planted on the seat. Repeat twice.",
            },
        },
        chestOpener = {
            name = "Chest Opener",
            flavor = "Stand proud, champion. Azeroth is watching.",
            steps = {
                "Stand up, feet hip-width apart.",
                "Interlace your fingers behind your back.",
                "Straighten your arms, squeeze your shoulder blades and lift your chest. Hold 15 seconds.",
                "Release, roll your shoulders and repeat once.",
            },
        },
        legExtensions = {
            name = "Seated Leg Extensions",
            flavor = "Your legs have been AFK long enough.",
            steps = {
                "Sit tall near the front of your seat, hands on your thighs.",
                "Straighten one leg until it is level, toes pulled toward you. Hold 3 seconds.",
                "Lower it slowly, then lift the other leg.",
                "Keep alternating for the full 30 seconds.",
            },
        },
        chairSquats = {
            name = "Chair Squats",
            flavor = "Arise, champion! The chair can wait.",
            steps = {
                "Sit near the front of your chair, feet flat and hip-width apart.",
                "Reach your arms forward and lean your chest over your knees.",
                "Push through your heels and stand up tall.",
                "Slowly sit back down. Repeat 8 to 10 times.",
            },
        },
        calfRaises = {
            name = "Calf Raises",
            flavor = "Tiptoe like you're sneaking past an elite.",
            steps = {
                "Stand at your desk, resting your fingertips on it.",
                "Rise up onto the balls of your feet.",
                "Hold 2 seconds at the top.",
                "Lower slowly. Repeat 15 times.",
            },
        },
        march = {
            name = "Marching in Place",
            flavor = "March like you're late for the raid.",
            steps = {
                "Stand tall beside your desk.",
                "Lift one knee toward hip height and swing the opposite arm forward.",
                "Lower it and lift the other knee.",
                "Keep a steady, brisk rhythm for 30 seconds.",
            },
        },
    },
}
