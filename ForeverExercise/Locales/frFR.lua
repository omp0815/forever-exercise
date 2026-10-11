local _, ns = ...
ns.locales = ns.locales or {}
ns.locales.frFR = {
    title = "Forever Exercise",
    notes = "Vous rappelle de faire un court exercice de bureau de temps en temps. /fex",

    ready = "Prêt ? %d secondes",
    start = "Commencer",
    done = "Terminé",
    another = "Un autre",
    snooze = "Reporter %d min",
    skip = "Passer",
    wellDone = "Bien joué, champion !",
    secondsLeft = "%ds",
    combatChat = "finissez le combat d'abord, champion.",

    exercising = "En exercice, plus que %ds",
    exerciseFinished = "Exercice terminé",
    exerciseReady = "Exercice prêt",
    paused = "En pause %s",
    pausedSnoozed = "En pause %s, reporté",
    resumes = "Reprend avec %s restant",
    dueCombat = "C'est l'heure, en attente de la fin du combat",
    snoozedNext = "Reporté, prochain exercice dans %s",
    nextExercise = "Prochain exercice dans %s",
    deathWaits = "L'exercice de mort attend que vous libériez votre esprit",
    inRaid = "dans un raid",
    inDungeon = "dans un donjon",
    clickSettings = "Cliquez pour ouvrir les options. Faites glisser pour déplacer.",

    reminderInterval = "Intervalle de rappel",
    reminderIntervalTip = "Minutes de jeu entre chaque rappel d'exercice.",
    minutes = "%d min",
    pauseInRaids = "Pause en raid",
    pauseInRaidsTip = "Arrête le minuteur tant que vous êtes dans un raid. Il reprend quand vous en sortez.",
    pauseInDungeons = "Pause en donjon",
    pauseInDungeonsTip = "Arrête le minuteur tant que vous êtes dans un donjon. Il reprend quand vous en sortez.",
    exerciseOnDeath = "Exercice à la mort",
    exerciseOnDeathTip = "Affiche un exercice quand vous mourez dans le monde, dans un champ de bataille ou dans une arène.",
    exerciseOnDungeonDeath = "Exercice à la mort en donjon",
    exerciseOnDungeonDeathTip = "Affiche un exercice quand vous mourez dans un donjon. Les raids ont leur propre option.",
    exerciseOnRaidDeath = "Exercice à la mort en raid",
    exerciseOnRaidDeathTip = "Affiche un exercice quand vous mourez dans un raid.",
    onlyGhost = "Seulement en fantôme",
    onlyGhostTip = "Attend que vous libériez votre esprit, au lieu d'afficher l'exercice sur le cadavre.",

    exercises = {
        neck = {
            name = "Inclinaisons du cou",
            flavor = "Même un griffon regarde des deux côtés avant d'atterrir.",
            steps = {
                "Assis droit, épaules relâchées, regard devant.",
                "Inclinez lentement une oreille vers l'épaule. Tenez 5 secondes.",
                "Revenez au centre, puis inclinez de l'autre côté. Tenez 5 secondes.",
                "Deux fois de chaque côté. Ne forcez jamais l'étirement.",
            },
        },
        shrugs = {
            name = "Haussements d'épaules",
            flavor = "Oubliez ce dernier wipe d'un haussement d'épaules.",
            steps = {
                "Assis droit, laissez pendre les bras.",
                "Montez les épaules vers les oreilles. Tenez 2 secondes.",
                "Laissez-les redescendre et reculer un peu. Expirez.",
                "Répétez 10 fois.",
            },
        },
        sideStretch = {
            name = "Étirement latéral, bras levés",
            flavor = "Tendez les bras comme si le loot venait de tomber.",
            steps = {
                "Assis droit, tendez les deux bras au-dessus de la tête, paumes jointes.",
                "Penchez-vous lentement d'un côté jusqu'à sentir l'étirement. Tenez 5 secondes.",
                "Revenez au centre, puis penchez-vous de l'autre côté. Tenez 5 secondes.",
                "Gardez les hanches collées au siège. Répétez deux fois.",
            },
        },
        chestOpener = {
            name = "Ouverture de poitrine",
            flavor = "Tenez-vous fier, champion. Azeroth vous regarde.",
            steps = {
                "Debout, pieds à largeur de hanches.",
                "Entrelacez les doigts derrière le dos.",
                "Tendez les bras, serrez les omoplates et levez la poitrine. Tenez 15 secondes.",
                "Relâchez, roulez les épaules. Encore une fois.",
            },
        },
        legExtensions = {
            name = "Extensions de jambes assises",
            flavor = "Vos jambes sont AFK depuis assez longtemps.",
            steps = {
                "Assis au bord, droit, mains sur les cuisses.",
                "Tendez une jambe horizontale, orteils ramenés vers vous. Tenez 3 secondes.",
                "Redescendez lentement, puis levez l'autre jambe.",
                "Continuez d'alterner pendant 30 secondes.",
            },
        },
        chairSquats = {
            name = "Squats sur chaise",
            flavor = "Debout, champion ! La chaise peut attendre.",
            steps = {
                "Assis au bord, pieds à plat, largeur de hanches.",
                "Tendez les bras vers l'avant et penchez la poitrine au-dessus des genoux.",
                "Poussez dans les talons et levez-vous droit.",
                "Rasseyez-vous lentement. Répétez 8 à 10 fois.",
            },
        },
        calfRaises = {
            name = "Élévations de mollets",
            flavor = "Sur la pointe, comme pour passer en douce devant un élite.",
            steps = {
                "Debout au bureau, posez le bout des doigts dessus.",
                "Montez sur l'avant des pieds.",
                "Tenez 2 secondes en haut.",
                "Redescendez lentement. Répétez 15 fois.",
            },
        },
        march = {
            name = "Marche sur place",
            flavor = "Marchez comme si vous étiez en retard pour le raid.",
            steps = {
                "Tenez-vous droit à côté du bureau.",
                "Levez un genou à hauteur de hanche et balancez le bras opposé vers l'avant.",
                "Posez-le, puis levez l'autre genou.",
                "Gardez un rythme vif et régulier pendant 30 secondes.",
            },
        },
    },
}
