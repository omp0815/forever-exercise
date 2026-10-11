local _, ns = ...
ns.locales = ns.locales or {}
ns.locales.esMX = {
    title = "Forever Exercise",
    notes = "Te recuerda hacer un ejercicio corto de escritorio de vez en cuando. /fex",

    ready = "¿Listo? %d segundos",
    start = "Iniciar",
    done = "Listo",
    another = "Otro",
    snooze = "Pospón %d min",
    skip = "Omitir",
    wellDone = "¡Bien hecho, campeón!",
    secondsLeft = "%ds",
    combatChat = "termina el combate primero, campeón.",

    exercising = "En ejercicio, %ds restantes",
    exerciseFinished = "Ejercicio terminado",
    exerciseReady = "Ejercicio listo",
    paused = "Pausado %s",
    pausedSnoozed = "Pausado %s, pospuesto",
    resumes = "Se reanuda con %s restantes",
    dueCombat = "Ya toca, esperando a que termine el combate",
    snoozedNext = "Pospuesto, siguiente ejercicio en %s",
    nextExercise = "Siguiente ejercicio en %s",
    deathWaits = "El ejercicio al morir espera hasta que liberes tu espíritu",
    inRaid = "en una banda",
    inDungeon = "en un calabozo",
    clickSettings = "Haz clic para abrir las opciones. Arrastra para mover.",

    reminderInterval = "Intervalo de aviso",
    reminderIntervalTip = "Minutos de juego entre cada aviso de ejercicio.",
    minutes = "%d min",
    pauseInRaids = "Pausar en bandas",
    pauseInRaidsTip = "Detiene el temporizador mientras estás en una banda. Se reanuda cuando sales.",
    pauseInDungeons = "Pausar en calabozos",
    pauseInDungeonsTip = "Detiene el temporizador mientras estás en un calabozo. Se reanuda cuando sales.",
    exerciseOnDeath = "Ejercicio al morir",
    exerciseOnDeathTip = "Muestra un ejercicio cuando mueres en el mundo, en un campo de batalla o en una arena.",
    exerciseOnDungeonDeath = "Ejercicio al morir en calabozo",
    exerciseOnDungeonDeathTip = "Muestra un ejercicio cuando mueres en un calabozo. Las bandas tienen su propia opción.",
    exerciseOnRaidDeath = "Ejercicio al morir en banda",
    exerciseOnRaidDeathTip = "Muestra un ejercicio cuando mueres en una banda.",
    onlyGhost = "Solo como fantasma",
    onlyGhostTip = "Espera a que liberes tu espíritu, en vez de mostrar el ejercicio sobre el cadáver.",

    exercises = {
        neck = {
            name = "Inclinaciones de cuello",
            flavor = "Hasta un grifo mira a ambos lados antes de aterrizar.",
            steps = {
                "Siéntate con la espalda recta, hombros relajados y la mirada al frente.",
                "Inclina despacio una oreja hacia el hombro. Mantén 5 segundos.",
                "Vuelve al centro y luego inclina hacia el otro lado. Mantén 5 segundos.",
                "Repite cada lado dos veces. Nunca fuerces el estiramiento.",
            },
        },
        shrugs = {
            name = "Encogimientos de hombros",
            flavor = "Encógete de hombros ante esa última muerte del grupo.",
            steps = {
                "Siéntate con la espalda recta y deja los brazos sueltos.",
                "Sube ambos hombros hacia las orejas. Mantén 2 segundos.",
                "Déjalos caer hacia abajo y un poco hacia atrás. Exhala.",
                "Repite 10 veces.",
            },
        },
        sideStretch = {
            name = "Estiramiento lateral en alto",
            flavor = "Estira como si el botín acabara de caer.",
            steps = {
                "Siéntate con la espalda recta y estira ambos brazos sobre la cabeza, palmas juntas.",
                "Inclínate despacio a un lado hasta sentir el estiramiento. Mantén 5 segundos.",
                "Vuelve al centro y luego inclínate al otro lado. Mantén 5 segundos.",
                "Mantén las caderas pegadas al asiento. Repite dos veces.",
            },
        },
        chestOpener = {
            name = "Apertura de pecho",
            flavor = "Saca pecho, campeón. Azeroth te observa.",
            steps = {
                "Ponte de pie, con los pies separados al ancho de las caderas.",
                "Entrelaza los dedos detrás de la espalda.",
                "Estira los brazos, aprieta los omóplatos y saca el pecho. Mantén 15 segundos.",
                "Suelta, haz rodar los hombros y repite una vez.",
            },
        },
        legExtensions = {
            name = "Extensiones de piernas sentado",
            flavor = "Tus piernas llevan demasiado tiempo AUS.",
            steps = {
                "Siéntate al borde del asiento, espalda recta y manos en los muslos.",
                "Estira una pierna en horizontal, con los dedos del pie hacia ti. Mantén 3 segundos.",
                "Bájala despacio y luego levanta la otra pierna.",
                "Sigue alternando durante los 30 segundos.",
            },
        },
        chairSquats = {
            name = "Sentadillas en silla",
            flavor = "¡Arriba, campeón! La silla puede esperar.",
            steps = {
                "Siéntate al borde de la silla, con los pies planos en el suelo, separados al ancho de las caderas.",
                "Lleva los brazos al frente e inclina el pecho sobre las rodillas.",
                "Empuja con los talones y ponte de pie con la espalda recta.",
                "Siéntate de nuevo despacio. Repite de 8 a 10 veces.",
            },
        },
        calfRaises = {
            name = "Elevaciones de pantorrillas",
            flavor = "De puntitas, como si pasaras en sigilo junto a un élite.",
            steps = {
                "Ponte de pie frente al escritorio y apoya las yemas de los dedos en él.",
                "Elévate sobre la parte delantera de los pies.",
                "Mantén 2 segundos arriba.",
                "Baja despacio. Repite 15 veces.",
            },
        },
        march = {
            name = "Marcha en el lugar",
            flavor = "Marcha como si llegaras tarde a la banda.",
            steps = {
                "Ponte de pie junto al escritorio, con la espalda recta.",
                "Levanta una rodilla a la altura de la cadera y balancea el brazo opuesto hacia el frente.",
                "Bájala y levanta la otra rodilla.",
                "Mantén un ritmo constante y enérgico durante 30 segundos.",
            },
        },
    },
}
