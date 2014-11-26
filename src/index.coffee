hasOwn = Function::call.bind Object::hasOwnProperty

get = (key) ->
  (obj) ->
    obj[key]

KeyedQueue = ->

  store = Object.create null
  queue = []

  instance =
    enqueue: (key, value) ->
      return null if instance.has key
      queue.push key: key, value: value
      store[key] = value
      return queue.length

    dequeue: ->
      item = do queue.shift
      delete store[item.key]
      return item.value

    get: (key) ->
      return store[key]

    has: (key) ->
      return hasOwn store, key

    peek: ->
      return null unless queue.length
      return store[queue[0].key]

    size: ->
      return queue.length

    keys: ->
      return queue.map get "key"

  instance

module.exports = KeyedQueue
