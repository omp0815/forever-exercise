// node browser/check.js — validates Exercises.lua, the locale files, and that
// the English exercise text in both places still matches.
const assert = require('node:assert/strict');
const { readFileSync, readdirSync } = require('node:fs');
const { join } = require('node:path');
const { loadData, parseLocale, nextFromDeck, deathReaction, statusLines, groupTimer } = require('./luadata.js');

const D = loadData(readFileSync(join(__dirname, '../ForeverExercise/Exercises.lua'), 'utf8'));
const joints = new Set(D.bones.flat());

for (const [name, pose] of Object.entries(D.poses)) {
  assert.deepEqual(new Set(Object.keys(pose)), joints, `base pose ${name} must define every joint`);
}

const ids = new Set();
for (const ex of D.exercises) {
  const at = (msg) => `${ex.id}: ${msg}`;
  assert(!ids.has(ex.id), at('duplicate id'));
  ids.add(ex.id);
  assert(ex.name && ex.flavor, at('needs name and flavor'));
  assert(ex.steps.length > 0, at('needs steps'));
  assert(ex.tempo > 0, at('needs a tempo'));
  assert(D.poses[ex.base], at(`unknown base ${ex.base}`));
  for (const p of ex.props) assert(D.props[p], at(`unknown prop ${p}`));
  assert(ex.poses.length >= 2, at('needs at least 2 poses to animate'));
  ex.poses.forEach((override, n) => {
    for (const j of Object.keys(override)) assert(joints.has(j), at(`pose ${n + 1} has unknown joint ${j}`));
  });
  for (const frame of ex.frames) {
    for (const [j, [x, y]] of Object.entries(frame)) {
      assert(x >= 0 && x <= 100 && y >= 0 && y <= 100, at(`${j} outside the 100x100 box`));
    }
  }
}

// A full deck plays every exercise once, and the next deck does not reopen
// with the one that just played. random() is fixed so the reshuffle lands on it.
{
  const deck = [];
  let current;
  const played = [];
  for (let i = 0; i < D.exercises.length; i++) {
    current = nextFromDeck(deck, D.exercises, current);
    played.push(current.id);
  }
  assert.equal(new Set(played).size, played.length, 'a deck repeats an exercise');

  const two = [{ id: 'a' }, { id: 'b' }];
  const rolls = [0, 0.5, 0]; // first shuffle, reshuffle onto the last played, then the swap off it
  let roll = 0;
  const small = [];
  const first = nextFromDeck(small, two, null, () => rolls[roll++]);
  const second = nextFromDeck(small, two, first, () => rolls[roll++]);
  const third = nextFromDeck(small, two, second, () => rolls[roll++]);
  assert.notEqual(third.id, second.id, 'a new deck opened with the exercise just played');
  assert.equal(roll, rolls.length);
}

assert.equal(deathReaction(true, false, null), 'show');
assert.equal(deathReaction(true, true, null), 'wait');
assert.equal(deathReaction(false, true, null), 'ignore');
assert.equal(deathReaction(true, true, true), 'show');
assert.equal(deathReaction(true, true, false), 'ignore');
assert.equal(deathReaction(true, false, true), 'ignore');

assert.deepEqual(statusLines({ shown: false, left: 90 }), ['Next exercise in 1:30']);
assert.deepEqual(statusLines({ shown: false, left: 90, snoozed: true }), ['Snoozed, next exercise in 1:30']);
assert.deepEqual(statusLines({ shown: false, held: 'raid', snoozed: true, left: 65 }),
  ['Snoozed, next exercise in 1:05', 'The window waits until you leave']);
assert.deepEqual(statusLines({ shown: false, dueHeld: true, held: 'raid', left: 0 }),
  ['Due now, waiting until you leave the raid']);
assert.deepEqual(statusLines({ shown: false, dueHeld: true, held: 'dungeon', left: 0 }),
  ['Due now, waiting until you leave the dungeon']);
assert.deepEqual(statusLines({ shown: false, due: true, left: 0 }), ['Due now, waiting for combat to end']);
assert.equal(groupTimer([{ leader: false, seconds: 30 }, { leader: true, seconds: 100 }]), 100);
assert.equal(groupTimer([{ leader: false, seconds: 30 }, { leader: false, seconds: 10 }]), 10);
assert.equal(groupTimer([]), null);
assert.deepEqual(statusLines({ shown: true, remaining: 12.2 }), ['Exercising, 13s left']);
assert.deepEqual(statusLines({ shown: true, finished: true }), ['Exercise finished']);
assert.deepEqual(statusLines({ shown: true }), ['Exercise ready']);

const LOCALES = join(__dirname, '../ForeverExercise/Locales');
const tokens = (s) => (String(s).match(/%[ds]/g) || []).join(',');

function sameShape(english, translated, path, code) {
  if (typeof english === 'string') {
    assert.equal(typeof translated, 'string', `${code} ${path} should be text`);
    assert.equal(tokens(translated), tokens(english), `${code} ${path} format tokens`);
    return;
  }
  if (Array.isArray(english)) {
    assert.ok(Array.isArray(translated), `${code} ${path} should be a list`);
    assert.equal(translated.length, english.length, `${code} ${path} length`);
    english.forEach((item, i) => sameShape(item, translated[i], `${path}[${i}]`, code));
    return;
  }
  assert.deepEqual(Object.keys(translated).sort(), Object.keys(english).sort(), `${code} ${path} keys`);
  for (const key of Object.keys(english)) sameShape(english[key], translated[key], `${path}.${key}`, code);
}

const english = parseLocale(readFileSync(join(LOCALES, 'enUS.lua'), 'utf8'));
assert.equal(english.code, 'enUS');
assert.deepEqual(D.exercises.map((ex) => ex.id).sort(), Object.keys(english.table.exercises).sort(),
  'exercise ids in Exercises.lua and enUS.lua');
for (const ex of D.exercises) {
  const pack = english.table.exercises[ex.id];
  assert.equal(ex.name, pack.name, `${ex.id} name`);
  assert.equal(ex.flavor, pack.flavor, `${ex.id} flavor`);
  assert.deepEqual(ex.steps, pack.steps, `${ex.id} steps`);
}
const codes = readdirSync(LOCALES).filter((name) => name.endsWith('.lua')).map((name) => name.slice(0, -4)).sort();
assert.deepEqual(codes, ['deDE', 'enUS', 'esES', 'esMX', 'frFR', 'itIT', 'koKR', 'ptBR', 'ruRU', 'zhCN', 'zhTW']);
for (const code of codes) {
  if (code === 'enUS') continue;
  const locale = parseLocale(readFileSync(join(LOCALES, `${code}.lua`), 'utf8'));
  assert.equal(locale.code, code);
  sameShape(english.table, locale.table, code, code);
}

console.log(`ok: ${D.exercises.length} exercises, ${codes.length} locales`);
