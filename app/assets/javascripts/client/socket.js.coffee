class Socket

  constructor: (@url, @local_player_id) ->
    _.extend(this, Backbone.Events)
    _.bindAll(this)

  onopen: =>
    @trigger('socket:connected', 'Connected')

  onerror: (e) =>
    @trigger('socket:error', e)
    console.error("Websocket failure: #{e}")

  onclose: =>
    @trigger('socket:disconnected', 'Disconnected')

  onmessage: (msg) =>
    data = JSON.parse(msg.data)
    data.id = data._id if data._id

    if data.clazz == 'Card'
      # LEGACY
      data.user_id = data.player_id if data.player_id?

      card = Card.all[data.id] || new Card(data)
      card.load(data)

      if data.collection_id?
        if card.collection
          card.collection.remove(card)

        add_to = CardCollection.all[data.collection_id]
        add_to.add(card)

    if data.clazz == 'Action'
      action = new Action(data)
      action.run()

    if data.clazz == 'Message'
      Message.all.add(new Message(data))

    if data.clazz == 'Player'
      if user = User.all.get(data.id)
        user.set(data)
      else
        User.all.add(new User(data))

  connect: ->
    @ws = new WebSocket(@url)
    @ws.onopen = @onopen
    @ws.onclose = @onclose
    @ws.onerror = @onerror
    @ws.onmessage = @onmessage
    this

  send_object: (obj) =>
#    console.debug "Sending object"
#    console.debug obj
    @ws.send(JSON.stringify(obj.toJSON()))

Backbone.sync = (method, model, success, error) ->
  model.clazz = model.constructor.name
  Socket.instance.send_object(model)
  return true

window.Socket = Socket