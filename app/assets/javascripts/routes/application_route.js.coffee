Mana.ApplicationRoute = Ember.Route.extend({
  model: ->
    # Getting game ID from the URL
    # not really an Ember.js showcase, but it works
    atoms = window.location.pathname.split('/')
    game_id = atoms[atoms.length - 1]
    @store.find('game',game_id)

  actions:
    tap: (card) ->
      card.tap()

    flip: (card) ->
      card.flip()

    toggleCovered: (card) ->
      card.toggleCovered()
      true

    shuffle: (slot) ->
      console.debug "Shuffling #{slot.get('name')}"
      slot.shuffle()
      false

    draw_initial_hand: ->
      player = @modelFor('application').get("current_player")
      hand = player.get('hand')
      deck = player.get('deck')
      deck.get('top').moveTo(hand) for i in [0..6]

    # TODO: replace with moveTo on card as above ^
    move_card_to: (card,target_name,unshift = false) ->
      now = @modelFor('application').get("current_player.#{target_name}")
      before = card.get('slot')
      before.get('cards').removeObject(card)

      if unshift
        now.get('cards').unshiftObject(card)
      else
        now.get('cards').pushObject(card)

      before.save()
      now.save()
      card.set('slot_id',now.get('id'))
      false

})
