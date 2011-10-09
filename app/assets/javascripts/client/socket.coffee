class Socket

  constructor: (@url, @game_id) ->
    _.extend(this, Backbone.Events)
    _.bindAll(this)

  onopen: =>
    @trigger('socket:connected', 'Connected')

  onerror: (e) =>
    @trigger('socket:error', e)

  onclose: =>
    @trigger('socket:disconnected', 'Disconnected')
    alert('Disconnected!')

  onmessage: (msg) =>
    data = JSON.parse(msg.data)
    data.id = data._id if data._id

    console.debug 'Received'
    console.debug data

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

    if data.clazz == 'Message'
      @trigger('arrived:message', data.message)

    if data.clazz == 'Player'
      if user = User.all.get(data.id)
        user.set(data.user)
      else
        user = new User(data)
        User.all.add(user)
        user_view = new UserView({ model: user })
        user_view.render()

  connect: ->
    @ws = new WebSocket(@url)
    @ws.onopen = @onopen
    @ws.onclose = @onclose
    @ws.onerror = @onerror
    @ws.onmessage = @onmessage
    this

  send_object: (obj) ->
    console.info obj
    @ws.send(obj)


Backbone.sync = (method, model, success, error) ->
  console.info "Sending #{method}"
  model.clazz = model.constructor.name
  Socket.instance.send_object( JSON.stringify(model.toJSON()))
  return true

window.Socket = Socket