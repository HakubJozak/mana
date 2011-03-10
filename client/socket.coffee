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

    if data.card
      # TODO: don't use view to find the card
      # card = $("#card-#{data.card.id}").ob().model
      # CardCollection.all[data.card.collection_id].get - WON'T WORK - the user could change the location meanwhile
      card = $("#card-#{data.card.id}").ob().model
      card.set(data.card)

    if data.message
      Chat.instance.add(new Message(data.message))

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
  start_game: (name, cards) ->
    @ws.send(JSON.stringify({
      action: 'connect',
      game_id: @game_id,
      cards: cards,
      name: name
    }))