local _, ns = ...

-- Shared with the browser preview (browser/luadata.js), which only reads
-- `ns.<name> = { ... }` table literals: keep this file to plain tables of
-- numbers, "strings", true/false and -- comments.
--
-- Pictograms live in a 100 x 100 box, origin bottom-left, y up.
-- Joints starting with "l" are the far side: drawn lighter in side views.

ns.defaults = {
    interval = 30,          -- minutes between reminders
    pauseInRaid = true,
    pauseInDungeon = true,
    syncTimers = true,
    minimapAngle = 225,     -- degrees around the minimap, 0 is east
    exerciseOnDeath = false,
    exerciseOnDeathGhost = false,
    exerciseOnDungeonDeath = false,
    exerciseOnDungeonDeathGhost = false,
    exerciseOnRaidDeath = false,
    exerciseOnRaidDeathGhost = false,
}

ns.timing = {
    duration = 30,          -- seconds per exercise
    snooze = 5,             -- minutes
}

ns.style = {
    ink = { 0.24, 0.13, 0.05, 1 },
    far = { 0.52, 0.38, 0.22, 1 },
    prop = { 0.45, 0.33, 0.20, 0.55 },
    thickness = 3.4,
    propThickness = 1.6,
    headRadius = 6.5,
    hold = 0.4,             -- share of each tempo step spent holding the pose
}

ns.bones = {
    { "hip", "lKn" }, { "lKn", "lAn" }, { "lAn", "lTo" },
    { "neck", "lSh" }, { "lSh", "lEl" }, { "lEl", "lHa" },
    { "neck", "hip" }, { "neck", "head" },
    { "hip", "rKn" }, { "rKn", "rAn" }, { "rAn", "rTo" },
    { "neck", "rSh" }, { "rSh", "rEl" }, { "rEl", "rHa" },
}

ns.poses = {
    seatedFront = {
        head = { 50, 70 }, neck = { 50, 61 }, hip = { 50, 30 },
        lSh = { 41, 58 }, lEl = { 37, 45 }, lHa = { 40, 33 },
        rSh = { 59, 58 }, rEl = { 63, 45 }, rHa = { 60, 33 },
        lKn = { 42, 27 }, lAn = { 42, 8 }, lTo = { 38, 5 },
        rKn = { 58, 27 }, rAn = { 58, 8 }, rTo = { 62, 5 },
    },
    seatedSide = {
        head = { 38, 67 }, neck = { 37, 58 }, hip = { 36, 27 },
        lSh = { 37, 55 }, lEl = { 39, 42 }, lHa = { 50, 31 },
        rSh = { 37, 55 }, rEl = { 41, 42 }, rHa = { 52, 31 },
        lKn = { 54, 28 }, lAn = { 53, 8 }, lTo = { 59, 5 },
        rKn = { 57, 28 }, rAn = { 56, 8 }, rTo = { 62, 5 },
    },
    standingSide = {
        head = { 50, 86 }, neck = { 49, 77 }, hip = { 49, 46 },
        lSh = { 49, 74 }, lEl = { 47, 61 }, lHa = { 48, 48 },
        rSh = { 49, 74 }, rEl = { 51, 61 }, rHa = { 53, 48 },
        lKn = { 48, 27 }, lAn = { 47, 9 }, lTo = { 55, 5 },
        rKn = { 51, 27 }, rAn = { 50, 9 }, rTo = { 58, 5 },
    },
}

-- Line segments { x1, y1, x2, y2 }
ns.props = {
    floor = { { 6, 4, 94, 4 } },
    chairFront = {
        { 30, 24, 70, 24 }, { 32, 24, 32, 4 }, { 68, 24, 68, 4 },
        { 34, 24, 34, 54 }, { 66, 24, 66, 54 }, { 34, 54, 66, 54 },
    },
    chairSide = {
        { 24, 24, 48, 24 }, { 24, 24, 22, 60 }, { 26, 24, 26, 4 }, { 46, 24, 46, 4 },
    },
    desk = {
        { 58, 52, 95, 52 }, { 58, 49, 95, 49 }, { 88, 49, 88, 4 },
    },
}

-- Each pose overrides joints of `base`; the animation loops through them,
-- `tempo` seconds per pose.
ns.exercises = {
    {
        id = "neck",
        name = "Neck Tilts",
        flavor = "Even a gryphon looks both ways before landing.",
        base = "seatedFront",
        props = { "floor", "chairFront" },
        tempo = 2.2,
        poses = {
            {},
            { head = { 43, 67 } },
            {},
            { head = { 57, 67 } },
        },
        steps = {
            "Sit tall, shoulders relaxed, eyes forward.",
            "Slowly tilt one ear toward your shoulder. Hold 5 seconds.",
            "Return to center, then tilt to the other side. Hold 5 seconds.",
            "Repeat each side twice. Never force the stretch.",
        },
    },
    {
        id = "shrugs",
        name = "Shoulder Shrugs",
        flavor = "Shrug off that last wipe.",
        base = "seatedFront",
        props = { "floor", "chairFront" },
        tempo = 1.0,
        poses = {
            {},
            {
                lSh = { 42, 66 }, rSh = { 58, 66 }, lEl = { 38, 53 }, rEl = { 62, 53 },
                lHa = { 40, 40 }, rHa = { 60, 40 },
            },
        },
        steps = {
            "Sit tall and let your arms hang loose.",
            "Pull both shoulders up toward your ears. Hold 2 seconds.",
            "Let them drop down and slightly back. Breathe out.",
            "Repeat 10 times.",
        },
    },
    {
        id = "sideStretch",
        name = "Overhead Side Stretch",
        flavor = "Reach as if the loot just dropped.",
        base = "seatedFront",
        props = { "floor", "chairFront" },
        tempo = 2.0,
        poses = {
            { lEl = { 42, 72 }, rEl = { 58, 72 }, lHa = { 50, 84 }, rHa = { 50, 84 } },
            {
                neck = { 42, 60 }, head = { 40, 69 }, lSh = { 34, 55 }, rSh = { 51, 59 },
                lEl = { 31, 68 }, rEl = { 47, 73 }, lHa = { 36, 82 }, rHa = { 36, 82 },
            },
            { lEl = { 42, 72 }, rEl = { 58, 72 }, lHa = { 50, 84 }, rHa = { 50, 84 } },
            {
                neck = { 58, 60 }, head = { 60, 69 }, lSh = { 49, 59 }, rSh = { 66, 55 },
                lEl = { 53, 73 }, rEl = { 69, 68 }, lHa = { 64, 82 }, rHa = { 64, 82 },
            },
        },
        steps = {
            "Sit tall and reach both arms overhead, palms together.",
            "Lean slowly to one side until you feel the stretch. Hold 5 seconds.",
            "Come back to center, then lean to the other side. Hold 5 seconds.",
            "Keep your hips planted on the seat. Repeat twice.",
        },
    },
    {
        id = "chestOpener",
        name = "Chest Opener",
        flavor = "Stand proud, champion. Azeroth is watching.",
        base = "standingSide",
        side = true,
        props = { "floor" },
        tempo = 2.0,
        poses = {
            {},
            {
                neck = { 48, 77 }, head = { 47, 86 }, lSh = { 48, 74 }, rSh = { 48, 74 },
                lEl = { 41, 63 }, rEl = { 42, 63 }, lHa = { 37, 51 }, rHa = { 37, 51 },
            },
        },
        steps = {
            "Stand up, feet hip-width apart.",
            "Interlace your fingers behind your back.",
            "Straighten your arms, squeeze your shoulder blades and lift your chest. Hold 15 seconds.",
            "Release, roll your shoulders and repeat once.",
        },
    },
    {
        id = "legExtensions",
        name = "Seated Leg Extensions",
        flavor = "Your legs have been AFK long enough.",
        base = "seatedSide",
        side = true,
        props = { "floor", "chairSide" },
        tempo = 1.6,
        poses = {
            {},
            { rAn = { 75, 30 }, rTo = { 76, 37 } },
            {},
            { lAn = { 72, 30 }, lTo = { 73, 37 } },
        },
        steps = {
            "Sit tall near the front of your seat, hands on your thighs.",
            "Straighten one leg until it is level, toes pulled toward you. Hold 3 seconds.",
            "Lower it slowly, then lift the other leg.",
            "Keep alternating for the full 30 seconds.",
        },
    },
    {
        id = "chairSquats",
        name = "Chair Squats",
        flavor = "Arise, champion! The chair can wait.",
        base = "seatedSide",
        side = true,
        props = { "floor", "chairSide" },
        tempo = 1.4,
        poses = {
            { lEl = { 50, 55 }, rEl = { 51, 54 }, lHa = { 63, 56 }, rHa = { 64, 55 } },
            {
                neck = { 50, 55 }, head = { 55, 62 }, lSh = { 49, 52 }, rSh = { 49, 52 },
                lEl = { 62, 53 }, rEl = { 63, 52 }, lHa = { 75, 54 }, rHa = { 76, 53 },
            },
            {
                hip = { 52, 46 }, neck = { 53, 77 }, head = { 54, 86 }, lSh = { 53, 74 }, rSh = { 53, 74 },
                lEl = { 66, 74 }, rEl = { 67, 73 }, lHa = { 79, 74 }, rHa = { 80, 73 },
                lKn = { 52, 27 }, rKn = { 55, 27 },
            },
            {
                neck = { 50, 55 }, head = { 55, 62 }, lSh = { 49, 52 }, rSh = { 49, 52 },
                lEl = { 62, 53 }, rEl = { 63, 52 }, lHa = { 75, 54 }, rHa = { 76, 53 },
            },
        },
        steps = {
            "Sit near the front of your chair, feet flat and hip-width apart.",
            "Reach your arms forward and lean your chest over your knees.",
            "Push through your heels and stand up tall.",
            "Slowly sit back down. Repeat 8 to 10 times.",
        },
    },
    {
        id = "calfRaises",
        name = "Calf Raises",
        flavor = "Tiptoe like you're sneaking past an elite.",
        base = "standingSide",
        side = true,
        props = { "floor", "desk" },
        tempo = 1.2,
        poses = {
            { lEl = { 55, 63 }, rEl = { 57, 63 }, lHa = { 61, 53 }, rHa = { 63, 53 } },
            {
                head = { 50, 90 }, neck = { 49, 81 }, hip = { 49, 50 }, lSh = { 49, 78 }, rSh = { 49, 78 },
                lEl = { 57, 67 }, rEl = { 59, 67 }, lHa = { 61, 53 }, rHa = { 63, 53 },
                lKn = { 49, 31 }, rKn = { 52, 31 }, lAn = { 51, 13 }, rAn = { 54, 13 },
            },
        },
        steps = {
            "Stand at your desk, resting your fingertips on it.",
            "Rise up onto the balls of your feet.",
            "Hold 2 seconds at the top.",
            "Lower slowly. Repeat 15 times.",
        },
    },
    {
        id = "march",
        name = "Marching in Place",
        flavor = "March like you're late for the raid.",
        base = "standingSide",
        side = true,
        props = { "floor" },
        tempo = 0.9,
        poses = {
            {},
            {
                rKn = { 67, 46 }, rAn = { 66, 28 }, rTo = { 74, 26 },
                lEl = { 55, 63 }, lHa = { 63, 57 }, rEl = { 43, 63 }, rHa = { 39, 52 },
            },
            {},
            {
                lKn = { 66, 46 }, lAn = { 65, 28 }, lTo = { 73, 26 },
                rEl = { 56, 63 }, rHa = { 64, 57 }, lEl = { 42, 63 }, lHa = { 38, 52 },
            },
        },
        steps = {
            "Stand tall beside your desk.",
            "Lift one knee toward hip height and swing the opposite arm forward.",
            "Lower it and lift the other knee.",
            "Keep a steady, brisk rhythm for 30 seconds.",
        },
    },
}
