var assert = require("assert");
var KeyedQueue = require("./");

var queue;

beforeEach(function () {
  queue = KeyedQueue();
})

describe("#enqueue", function () {
  it("adds an item to the back of the queue, returning the queue size", function () {
    queue.enqueue("key", "value");
    assert.equal(queue.size(), 1);
  });

  it("doesn't add an item if an item with that key is already present, returns null", function () {
    assert.equal(queue.enqueue('a', 'b'), 1);
    assert.equal(queue.size(), 1);
    assert.equal(queue.enqueue('a', 'c'), null);
    assert.equal(queue.size(), 1);
    assert.equal(queue.enqueue('b', 'c'), 2);
    assert.equal(queue.size(), 2);
    queue.dequeue();
    assert.equal(queue.size(), 1);
    assert.equal(queue.enqueue('a', 'z'), 2);
    assert.equal(queue.size(), 2);
  });
});

describe("#dequeue", function () {
  it("removes an item from the front of the queue, returning the value", function () {
    queue.enqueue('a', 1);
    queue.enqueue('b', 2);
    queue.enqueue('c', 3);
    assert.equal(queue.dequeue(), 1);
    assert.equal(queue.dequeue(), 2);
    queue.enqueue('d', 4);
    assert.equal(queue.dequeue(), 3);
    assert.equal(queue.dequeue(), 4);
  });
});

describe("#get", function () {
  it("retrieves the value for a given key, or `undefined` if key not in queue", function () {
    queue.enqueue('a', 1);
    queue.enqueue('b', 2);
    queue.enqueue('c', 3);

    assert.equal(queue.get('a'), 1);
    assert.equal(queue.get('b'), 2);
    assert.equal(queue.get('c'), 3);

    queue.dequeue();
    assert.equal(queue.get('a'), undefined);
  });
});

describe("#has", function () {
  it("returns whether or not a key is in the queue", function () {
    queue.enqueue('a', 1);
    queue.enqueue('b', 2);
    queue.enqueue('c', 3);
    
    assert.equal(queue.has('a'), true);
    assert.equal(queue.has('b'), true);
    assert.equal(queue.has('c'), true);

    queue.dequeue();
    assert.equal(queue.has('a'), false);
    assert.equal(queue.has('b'), true);
    assert.equal(queue.has('c'), true);

    queue.dequeue();
    assert.equal(queue.has('a'), false);
    assert.equal(queue.has('b'), false);
    assert.equal(queue.has('c'), true);

    queue.dequeue();
    assert.equal(queue.has('a'), false);
    assert.equal(queue.has('b'), false);
    assert.equal(queue.has('c'), false);
  });
});

describe("#peek", function () {
  it("returns the first value in the queue without removing it, or undefined if queue is empty", function () {
    queue.enqueue('a', 1);
    queue.enqueue('b', 2);
    queue.enqueue('c', 3);
    assert.equal(queue.peek(), 1);

    queue.dequeue();
    assert.equal(queue.peek(), 2);

    queue.dequeue();
    assert.equal(queue.peek(), 3);

    queue.dequeue()
    assert.equal(queue.peek(), undefined);
  });
});

describe("#size", function () {
  it("returns the number of items in the queue", function () {
    assert.equal(queue.size(), 0);
    queue.enqueue('a', 1);
    assert.equal(queue.size(), 1);
    queue.enqueue('b', 2);
    assert.equal(queue.size(), 2);
    queue.enqueue('c', 3);
    assert.equal(queue.size(), 3);
    queue.dequeue();
    assert.equal(queue.size(), 2);
    queue.dequeue();
    assert.equal(queue.size(), 1);
    queue.dequeue();
    assert.equal(queue.size(), 0);
  });
});