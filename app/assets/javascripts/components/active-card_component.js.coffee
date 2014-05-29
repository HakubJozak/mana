# -*- tab-width: 2; -*-

Mana.ActiveCardComponent = Ember.Component.extend({
  click: (event) ->
    card = @get('card')
    if event.button == 1
      card.set('tapped', !card.get('tapped'))
    else
      card.set('flipped', !card.get('flipped'))
})
