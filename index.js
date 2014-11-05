function KeyedQueue () {
  var store = Object.create(null);
  var queue = [];
  
  var instance = {
    enqueue: function (key, value) {
      if (!instance.has(key)) {
        queue.push({key: key, value: value})
        store[key] = value;
        return queue.length;
      }
      return null;
    },
    dequeue: function () {
      var item = queue.shift();
      delete store[item.key];
      return item.value;
    },
    get: function (key) {
      return store[key];
    },
    has: function (key) {
      return store[key] !== undefined;
    },
    peek: function () {
      if (queue.length === 0) {
        return undefined;
      }
      var key = queue[0].key
      return store[key];
    },
    size: function () {
      return queue.length;
    }
  };

  return instance;
};

module.exports = KeyedQueue;