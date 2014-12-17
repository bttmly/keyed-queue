assert = require "assert"
KeyedQueue = require "../src/index.coffee"

queue = undefined

beforeEach ->
  queue = do KeyedQueue

describe "#enqueue", ->
  it "adds an item to the back of the queue, returning the queue size", ->
    queue.enqueue "key", "value"
    assert.equal queue.size(), 1

  it "doesn't add an item if an item with that key is already present, returns null", ->
    assert.equal queue.enqueue("a", "b"), 1
    assert.equal queue.size(), 1
    assert.equal queue.enqueue("a", "c"), null
    assert.equal queue.size(), 1
    assert.equal queue.enqueue("b", "c"), 2
    assert.equal queue.size(), 2
    queue.dequeue()
    assert.equal queue.size(), 1
    assert.equal queue.enqueue("a", "z"), 2
    assert.equal queue.size(), 2


describe "#dequeue", ->
  it "removes an item from the front of the queue, returning the value", ->
    queue.enqueue "a", 1
    queue.enqueue "b", 2
    queue.enqueue "c", 3
    assert.equal queue.dequeue(), 1
    assert.equal queue.dequeue(), 2
    queue.enqueue "d", 4
    assert.equal queue.dequeue(), 3
    assert.equal queue.dequeue(), 4

describe "#get", ->
  it "retrieves the value for a given key, or `undefined` if key not in queue", ->
    queue.enqueue "a", 1
    queue.enqueue "b", 2
    queue.enqueue "c", 3
    assert.equal queue.get("a"), 1
    assert.equal queue.get("b"), 2
    assert.equal queue.get("c"), 3
    queue.dequeue()
    assert.equal queue.get("a"), undefined

describe "#has", ->
  it "returns whether or not a key is in the queue", ->
    queue.enqueue "a", 1
    queue.enqueue "b", 2
    queue.enqueue "c", 3
    assert.equal queue.has("a"), true
    assert.equal queue.has("b"), true
    assert.equal queue.has("c"), true
    queue.dequeue()
    assert.equal queue.has("a"), false
    assert.equal queue.has("b"), true
    assert.equal queue.has("c"), true
    queue.dequeue()
    assert.equal queue.has("a"), false
    assert.equal queue.has("b"), false
    assert.equal queue.has("c"), true
    queue.dequeue()
    assert.equal queue.has("a"), false
    assert.equal queue.has("b"), false
    assert.equal queue.has("c"), false

describe "#peek", ->
  it "returns the first value in the queue without removing it, or undefined if queue is empty", ->
    queue.enqueue "a", 1
    queue.enqueue "b", 2
    queue.enqueue "c", 3
    assert.equal queue.peek(), 1
    queue.dequeue()
    assert.equal queue.peek(), 2
    queue.dequeue()
    assert.equal queue.peek(), 3
    queue.dequeue()
    assert.equal queue.peek(), undefined

describe "#size", ->
  it "returns the number of items in the queue", ->
    assert.equal queue.size(), 0
    queue.enqueue "a", 1
    assert.equal queue.size(), 1
    queue.enqueue "b", 2
    assert.equal queue.size(), 2
    queue.enqueue "c", 3
    assert.equal queue.size(), 3
    queue.dequeue()
    assert.equal queue.size(), 2
    queue.dequeue()
    assert.equal queue.size(), 1
    queue.dequeue()
    assert.equal queue.size(), 0

describe "#keys", ->
  it "returns an array of keys in the queue", ->
    assert.deepEqual queue.keys(), []
    queue.enqueue "a", 1
    assert.deepEqual queue.keys(), ["a"]
    queue.enqueue "b", 2
    assert.deepEqual queue.keys(), ["a", "b"]
    queue.enqueue "c", 3
    assert.deepEqual queue.keys(), ["a", "b", "c"]
    queue.dequeue()
    assert.deepEqual queue.keys(), ["b", "c"]
    queue.dequeue()
    assert.deepEqual queue.keys(), ["c"]
    queue.dequeue()
    assert.deepEqual queue.keys(), []

describe "#clear", ->
  it "clears all items from queue", ->
    queue.enqueue "a", 1
    queue.enqueue "b", 2
    queue.enqueue "c", 3
    assert.deepEqual queue.keys(), ["a", "b", "c"]
    queue.clear()
    assert.deepEqual queue.keys(), []