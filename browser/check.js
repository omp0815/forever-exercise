// node browser/check.js — validates ForeverExercise/Exercises.lua
const assert = require('node:assert/strict');
const { readFileSync } = require('node:fs');
const { join } = require('node:path');
const { loadData, nextFromDeck, deathReaction, statusLines } = require('./luadata.js');

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
assert.deepEqual(statusLines({ shown: false, paused: 'in a raid', snoozed: true, left: 65 }),
  ['Paused in a raid, snoozed', 'Resumes with 1:05 left']);
assert.deepEqual(statusLines({ shown: false, due: true, left: 0 }), ['Due now, waiting for combat to end']);
assert.deepEqual(statusLines({ shown: true, remaining: 12.2 }), ['Exercising, 13s left']);
assert.deepEqual(statusLines({ shown: true, finished: true }), ['Exercise finished']);
assert.deepEqual(statusLines({ shown: true }), ['Exercise ready']);

console.log(`ok: ${D.exercises.length} exercises`);
