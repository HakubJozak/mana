Mana.IndexRoute = Ember.Route.extend({
  model: ->
    # Getting game ID from the URL
    # not really an Ember.js showcase, but it works
    atoms = window.location.pathname.split('/')
    game_id = atoms[atoms.length - 1]
    @store.find('game',game_id)

  actions:
    send_message: ->
      console.info 'done' + @get('newMessage')
      @store.createRecord('message',text: 'blah')
      false

    add_live: (player) ->
      player.adjust_lives(1)
      false

    subtract_live: (player) ->
      player.adjust_lives(-1)
      false

})
