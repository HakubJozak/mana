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

#    if data.card
      # collection = CardCollection.get_by_id(data.card.collection)
      # if card = collection.find(data.card.id)
      #   card.set(data.card)
      # else
      #   console.error('Non-existing card')
      # TODO - move creation code here from User?
      #  $('#' + id + ' .library').ob().dropLocally(view);
      #  TODO: give to correct user

    if data.message
      Chat.instance.add(new Message(data.message))

    if data.user
      if user = User.all.find(data.user.id)
        user.set(data.user)
      else
        user = new User(data.user)
        User.all.add(user)
        new UserView({ model: user })
        user.library.trigger('add')

  connect: ->
    @ws = new WebSocket(@url)
    @ws.onopen = @onopen
    @ws.onclose = @onclose
    @ws.onerror = @onerror
    @ws.onmessage = @onmessage
    this

  send_object: (obj) ->
    @ws.send(JSON.stringify(obj))

  # LEGACY - transform it to User.save and Library.save
  start_game: (name, cards) ->
    @send_object {
      action: 'connect',
      game_id: @game_id,
      cards: cards,
      name: name
    }