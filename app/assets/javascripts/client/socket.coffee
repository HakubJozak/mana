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
    alert('Disconnected!')

  onmessage: (msg) =>
    data = JSON.parse(msg.data)
    data.id = data._id if data._id

    if data.clazz == 'Card'
      # LEGACY
      data.user_id = data.player_id

      card = Card.all[data.id] || new Card(data)
      card.load(data)

      if card.collection && card.collection.id != data.collection_id
        card.collection.remove(card) if card.collection

      if !card.collection || card.collection.id != data.collection_id
        add_to = CardCollection.all[data.collection_id]
        add_to.add(card)

    if data.clazz == 'Action'
      console.debug 'action arrived'
      action = new Action(data)
      action.run()

    if data.clazz == 'Message'
      Message.all.add(new Message(data))

    if data.clazz == 'Player'
      if user = User.all.get(data.id)
        user.set(data.user)
      else
        data.local = true if data.id == @local_player_id
        user = new User(data)
        User.all.add(user)
        user_view = new UserView({ model: user })
        user_view.render()

        if user.local
          HandView.bind_controls(user)

  connect: ->
    @ws = new WebSocket(@url)
    @ws.onopen = @onopen
    @ws.onclose = @onclose
    @ws.onerror = @onerror
    @ws.onmessage = @onmessage
    this

  send_object: (obj) =>
    console.debug "Sending object"
    console.debug obj
    @ws.send(JSON.stringify(obj.toJSON()))

Backbone.sync = (method, model, success, error) ->
  model.clazz = model.constructor.name
  Socket.instance.send_object(model)
  return true

window.Socket = Socket