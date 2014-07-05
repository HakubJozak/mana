Mana.ApplicationRoute = Ember.Route.extend({
  model: ->
    # Getting game ID from the URL
    # not really an Ember.js showcase, but it works
    atoms = window.location.pathname.split('/')
    game_id = atoms[atoms.length - 1]
    @store.find('game',game_id)

  actions:
    move_card_to: (card,target_name) ->
      now = @modelFor('application').get('current_player.hand')
      before = card.get('slot')
      before.get('cards').removeObject(card)
      now.get('cards').pushObject(card)
      card.set('slot_id',now.get('id'))
      false

    add_live: (player) ->
      player.adjust_lives(1)
      false

    subtract_live: (player) ->
      player.adjust_lives(-1)
      false

})
