# -*- tab-width: 2; -*-

Mana.CardView = Ember.View.extend({
  templateName: 'card'

  contextMenu: (event) ->
    card = @get('content')
    card.toggleCovered()
    event.preventDefault()

  doubleClick: (event) ->
    if event.which == 1
      console.info 'should show detail'

  click: (event) ->
    card = @get('content')
    if event.which == 2
      card.flip()
    else
      card.tap()
})
