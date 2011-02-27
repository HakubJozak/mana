Backbone.sync = (method, model, success, error) ->
  console.debug method
  console.debug model
  name = model.constructor.name.toLowerCase()
  game.socket.send(JSON.stringify({ "#{name}": model }))
  model.set({ id: '223'})
  true
