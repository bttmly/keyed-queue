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
      return store[key]?

    peek: ->
      return undefined unless queue.length
      return store[queue[0].key]

    size: ->
      return queue.length

  instance

module.exports = KeyedQueue
