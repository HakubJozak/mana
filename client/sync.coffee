Backbone.sync = (method, model, success, error) ->
  console.debug method
  console.debug model
  name = model.constructor.name.toLowerCase()
  Socket.instance.send_object({ "#{name}": model })
  true
