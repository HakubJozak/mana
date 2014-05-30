# -*- tab-width: 2; -*-

Mana.ActiveCardComponent = Ember.Component.extend({
  contextMenu: (event) ->
    card = @get('card')
    card.toggleCovered()
    event.preventDefault()

  doubleClick: (event) ->
    if event.which == 1
      console.info 'should show detail'

  click: (event) ->
    card = @get('card')
    console.info event.which

    if event.which == 2
      card.flip()
    else
      card.tap()
})
