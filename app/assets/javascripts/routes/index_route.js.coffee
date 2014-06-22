Mana.IndexRoute = Ember.Route.extend({
  model: ->
    # Getting game ID from the URL
    # not really an Ember.js showcase, but it works
    atoms = window.location.pathname.split('/')
    game_id = atoms[atoms.length - 1]
    @store.find('game',game_id)

  actions:
    remove_stuff: ->
      @store.find('card',@id).then (value) ->
        window.slot.removeObject(value)
      @id -= 1;
      false

    add_stuff: ->
      @id += 1;
      @store.find('card',@id).then (value) ->
        window.slot.pushObject(value)
      false
})
