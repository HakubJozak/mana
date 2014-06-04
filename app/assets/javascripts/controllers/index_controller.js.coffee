Mana.IndexController = Ember.ObjectController.extend({
  players: (->
    @get('model.players').toArray()
    ).property('players')

  firstPlayer: ( ->
    @get('model.players').objectAt(0)
  ).property()


  battlefield: (->
    b = []
    p = @get('model.players')

    for i in [0..15]
      b.pushObject p.get('hand')
    b).property('players')
})
