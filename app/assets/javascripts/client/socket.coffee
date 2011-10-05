class Socket

  constructor: (@url, @game_id) ->
    _.extend(this, Backbone.Events)
    _.bindAll(this)

  onopen: =>
    @trigger('socket:connected', 'Connected')

  onerror: =>
    @trigger('socket:disconnected', 'Connection error')

  onclose: =>
    @trigger('socket:disconnected', 'Disconnected')

  onmessage: (msg) =>
    data = JSON.parse(msg.data)
    console.debug 'Received'
    console.debug data

    if data.card
      # TODO: don't use view to find the card
      # card = $("#card-#{data.card.id}").ob().model
      # CardCollection.all[data.card.collection_id].get - WON'T WORK - the user could change the location meanwhile
      card = $("#card-#{data.card.id}").ob().model
      add_to = CardCollection.all[data.card.collection_id]

      card.load(data.card)
      card.collection.remove(card)
      add_to.add(card)

    if data.message
      @trigger('arrived:message', data.message)

    if data.user
      console.info data.user

      if user = User.all.get(data.user.id)
        user.set(data.user)
      else
        user = new User(data.user)
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

  # LEGACY - transform it to User.save and Library.save
  start_game: (game, user) ->
    console.info('game')
    console.info(game)

    @ws.send(JSON.stringify({
      action: 'connect',
      game_id: game.id,
      player_id: user.id
    }))

Backbone.sync = (method, model, success, error) ->
  console.info "Sending #{method}"
  name = model.constructor.name.toLowerCase()

  params = {}
  params[name] = model.toJSON()
  # ({ "#{name}": model.toJSON() }

  Socket.instance.send_object( JSON.stringify(params))
  true


window.Socket = Socket