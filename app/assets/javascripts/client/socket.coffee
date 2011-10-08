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

  onmessage: (msg) =>
    data = JSON.parse(msg.data)
    data.id = data._id if data._id

    console.debug 'Received'
    console.debug data

    if data.clazz == 'Card'
      # TODO: don't use view to find the card
      # card = $("#card-#{data.card.id}").ob().model
      # CardCollection.all[data.card.collection_id].get - WON'T WORK - the user could change the location meanwhile
      card = $("#card-#{data.card.id}").ob().model
      add_to = CardCollection.all[data.card.collection_id]

      card.load(data.card)
      card.collection.remove(card)
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