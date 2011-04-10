Backbone.sync = (method, model, success, error) ->
  console.debug method

  name = model.constructor.name.toLowerCase()
  Socket.instance.send_object(JSON.stringify({ "#{name}": model.toJSON() }))
  true
