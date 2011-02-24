Backbone.sync = (method, model, success, error) ->
  console.debug "#{method} #{model.id}"
  console.debug model
  game.socket.send(JSON.stringify({ card: model }))

