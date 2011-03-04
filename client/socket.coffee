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
    command = JSON.parse(msg.data)

    if command.card
      card = CardCollection.all.get(command.card.id)
      card.set(command.card)

    if command.message
      Chat.instance.add(new Message(command.message))

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