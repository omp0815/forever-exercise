// Reads the `ns.<name> = { ... }` table literals of ForeverExercise/Exercises.lua.
// Supports what that file uses: tables, numbers, strings, booleans, -- comments.
function parseLuaData(src) {
  let i = 0;
  const line = () => src.slice(0, i).split('\n').length;
  const fail = (msg) => { throw new Error(`Exercises.lua line ${line()}: ${msg}`); };
  const sticky = (re) => { re.lastIndex = i; const m = re.exec(src); if (m) i = re.lastIndex; return m; };

  function skip() {
    while (sticky(/\s+|--[^\n]*/y));
  }

  function value() {
    skip();
    if (src[i] === '{') return table();
    if (src[i] === '"' || src[i] === "'") return string();
    const m = sticky(/-?\d+(\.\d+)?|true\b|false\b/y);
    if (!m) fail(`unexpected ${JSON.stringify(src.slice(i, i + 12))}`);
    return m[0] === 'true' ? true : m[0] === 'false' ? false : Number(m[0]);
  }

  function string() {
    const quote = src[i++];
    let s = '';
    while (src[i] !== quote) {
      if (i >= src.length || src[i] === '\n') fail('unterminated string');
      if (src[i] === '\\') i++;
      s += src[i++];
    }
    i++;
    return s;
  }

  function table() {
    i++;
    const list = [], map = {};
    for (;;) {
      skip();
      if (src[i] === '}') { i++; break; }
      const key = sticky(/([A-Za-z_]\w*)\s*=(?!=)/y);
      if (key) map[key[1]] = value(); else list.push(value());
      skip();
      if (src[i] === ',' || src[i] === ';') i++;
      else if (src[i] !== '}') fail('expected , or }');
    }
    const keyed = Object.keys(map).length > 0;
    if (keyed && list.length) fail('mixed list and keyed entries');
    return keyed ? map : list;
  }

  const ns = {};
  for (const m of src.matchAll(/^ns\.(\w+)\s*=\s*/gm)) {
    i = m.index + m[0].length;
    ns[m[1]] = value();
  }
  return ns;
}

// Same pose resolution as ForeverExercise.lua: each pose overrides its base.
function loadData(src) {
  const ns = parseLuaData(src);
  for (const ex of ns.exercises) ex.frames = ex.poses.map((p) => ({ ...ns.poses[ex.base], ...p }));
  return ns;
}

// One shuffled deck, like an iPod: every exercise plays once before any repeats.
// A fresh deck never opens with `current`. random() returns [0, 1).
// Mirrored by PickExercise in ForeverExercise/ForeverExercise.lua.
function nextFromDeck(deck, exercises, current, random = Math.random) {
  if (deck.length === 0) {
    for (const exercise of exercises) deck.push(exercise);
    for (let i = deck.length - 1; i > 0; i--) {
      const j = Math.floor(random() * (i + 1));
      [deck[i], deck[j]] = [deck[j], deck[i]];
    }
    if (deck[0] === current && deck.length > 1) {
      const j = 1 + Math.floor(random() * (deck.length - 1));
      [deck[0], deck[j]] = [deck[j], deck[0]];
    }
  }
  return deck.shift();
}

// What a death does. becameGhost is null at the corpse and true/false once
// PLAYER_ALIVE fires. Mirrors OnDeath/OnReleased in ForeverExercise.lua.
// Lines for the minimap tooltip. `paused` is "in a raid" or "in a dungeon".
// `left` is seconds. Mirrors TooltipLines in ForeverExercise.lua.
function statusLines(s) {
  const clock = (seconds) => {
    seconds = Math.max(0, Math.ceil(seconds));
    return `${Math.floor(seconds / 60)}:${String(seconds % 60).padStart(2, '0')}`;
  };
  if (s.shown) {
    if (s.remaining != null) return [`Exercising, ${Math.ceil(s.remaining)}s left`];
    if (s.finished) return ['Exercise finished'];
    return ['Exercise ready'];
  }
  if (s.paused) {
    return [`Paused ${s.paused}${s.snoozed ? ', snoozed' : ''}`, `Resumes with ${clock(s.left)} left`];
  }
  if (s.due) return ['Due now, waiting for combat to end'];
  const lines = [s.snoozed ? `Snoozed, next exercise in ${clock(s.left)}` : `Next exercise in ${clock(s.left)}`];
  if (s.waitForGhost) lines.push('Death exercise waits until you release your spirit');
  return lines;
}

function deathReaction(enabled, ghostsOnly, becameGhost) {
  if (becameGhost === null) return !enabled ? 'ignore' : ghostsOnly ? 'wait' : 'show';
  return enabled && ghostsOnly && becameGhost ? 'show' : 'ignore';
}

if (typeof module !== 'undefined') module.exports = { parseLuaData, loadData, nextFromDeck, deathReaction, statusLines };
