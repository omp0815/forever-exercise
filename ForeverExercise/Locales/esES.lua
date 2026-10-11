local _, ns = ...
ns.locales = ns.locales or {}
ns.locales.esES = {
    title = "Forever Exercise",
    notes = "Te recuerda hacer un breve ejercicio de escritorio de vez en cuando. /fex",

    ready = "¿Listo? %d segundos",
    start = "Empezar",
    done = "Hecho",
    another = "Otro",
    snooze = "Aplazar %d min",
    skip = "Saltar",
    wellDone = "¡Bien hecho, campeón!",
    secondsLeft = "%ds",
    combatChat = "termina el combate primero, campeón.",

    exercising = "En ejercicio, quedan %ds",
    exerciseFinished = "Ejercicio terminado",
    exerciseReady = "Ejercicio listo",
    paused = "Pausado %s",
    pausedSnoozed = "Pausado %s, aplazado",
    resumes = "Se reanuda con %s restantes",
    dueCombat = "Ya toca, esperando a que acabe el combate",
    snoozedNext = "Aplazado, siguiente ejercicio en %s",
    nextExercise = "Siguiente ejercicio en %s",
    deathWaits = "El ejercicio al morir espera a que liberes el espíritu",
    inRaid = "en una banda",
    inDungeon = "en una mazmorra",
    clickSettings = "Haz clic para abrir las opciones. Arrastra para mover.",

    reminderInterval = "Intervalo de aviso",
    reminderIntervalTip = "Minutos de juego entre avisos de ejercicio.",
    minutes = "%d min",
    pauseInRaids = "Pausar en bandas",
    pauseInRaidsTip = "Detiene el temporizador mientras estás en una banda. Se reanuda al salir.",
    pauseInDungeons = "Pausar en mazmorras",
    pauseInDungeonsTip = "Detiene el temporizador mientras estás en una mazmorra. Se reanuda al salir.",
    exerciseOnDeath = "Ejercicio al morir",
    exerciseOnDeathTip = "Muestra un ejercicio cuando mueres en el mundo, en un campo de batalla o en una arena.",
    exerciseOnDungeonDeath = "Ejercicio al morir en mazmorra",
    exerciseOnDungeonDeathTip = "Muestra un ejercicio cuando mueres en una mazmorra. Las bandas tienen su propia opción.",
    exerciseOnRaidDeath = "Ejercicio al morir en banda",
    exerciseOnRaidDeathTip = "Muestra un ejercicio cuando mueres en una banda.",
    onlyGhost = "Solo como fantasma",
    onlyGhostTip = "Espera a que liberes el espíritu, en vez de mostrar el ejercicio sobre el cadáver.",

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
            flavor = "Encógete de hombros ante la última derrota del grupo.",
            steps = {
                "Siéntate con la espalda recta y deja los brazos sueltos.",
                "Sube ambos hombros hacia las orejas. Mantén 2 segundos.",
                "Déjalos caer hacia abajo y un poco hacia atrás. Suelta el aire.",
                "Repite 10 veces.",
            },
        },
        sideStretch = {
            name = "Estiramiento lateral en alto",
            flavor = "Estira como si el botín acabara de caer.",
            steps = {
                "Siéntate con la espalda recta y estira ambos brazos por encima de la cabeza, palmas juntas.",
                "Inclínate despacio hacia un lado hasta notar el estiramiento. Mantén 5 segundos.",
                "Vuelve al centro y luego inclínate hacia el otro lado. Mantén 5 segundos.",
                "No despegues las caderas del asiento. Repite dos veces.",
            },
        },
        chestOpener = {
            name = "Apertura de pecho",
            flavor = "Saca pecho, campeón. Azeroth te observa.",
            steps = {
                "Ponte de pie, con los pies separados al ancho de las caderas.",
                "Entrelaza los dedos detrás de la espalda.",
                "Estira los brazos, aprieta los omóplatos y saca pecho. Mantén 15 segundos.",
                "Suelta, haz rodar los hombros y repite una vez.",
            },
        },
        legExtensions = {
            name = "Extensiones de piernas sentado",
            flavor = "Tus piernas ya llevan suficiente tiempo ausentes.",
            steps = {
                "Siéntate con la espalda recta en el borde del asiento, manos sobre los muslos.",
                "Estira una pierna hasta dejarla horizontal, con los dedos del pie hacia ti. Mantén 3 segundos.",
                "Bájala despacio y luego levanta la otra pierna.",
                "Sigue alternando durante los 30 segundos.",
            },
        },
        chairSquats = {
            name = "Sentadillas en silla",
            flavor = "¡Levántate, campeón! La silla puede esperar.",
            steps = {
                "Siéntate en el borde de la silla, con los pies apoyados en el suelo y separados al ancho de las caderas.",
                "Lleva los brazos hacia delante e inclina el pecho sobre las rodillas.",
                "Empuja con los talones y levántate con la espalda recta.",
                "Siéntate despacio de nuevo. Repite de 8 a 10 veces.",
            },
        },
        calfRaises = {
            name = "Elevaciones de gemelos",
            flavor = "De puntillas, como si pasaras en sigilo junto a un élite.",
            steps = {
                "Ponte de pie frente al escritorio, con las yemas de los dedos apoyadas en él.",
                "Elévate sobre la parte delantera de los pies.",
                "Mantén 2 segundos arriba.",
                "Baja despacio. Repite 15 veces.",
            },
        },
        march = {
            name = "Marcha en el sitio",
            flavor = "Marcha como si llegaras tarde a la banda.",
            steps = {
                "Ponte de pie, con la espalda recta, junto al escritorio.",
                "Levanta una rodilla hasta la altura de la cadera y balancea el brazo contrario hacia delante.",
                "Bájala y levanta la otra rodilla.",
                "Mantén un ritmo constante y vivo durante 30 segundos.",
            },
        },
    },
}
