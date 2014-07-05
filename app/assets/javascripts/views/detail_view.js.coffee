Mana.DetailView = Ember.View.extend
  templateName: 'detail'
  layoutName: 'popup'

  tap: (card) ->
    card.tap()

  flip: (card) ->
    card.flip()

  toggleCovered: (card) ->
    card.toggleCovered()
