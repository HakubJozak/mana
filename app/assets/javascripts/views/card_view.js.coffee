# -*- tab-width: 2; -*-

Mana.CardView = Ember.View.extend Mana.Draggable, {
  templateName: 'card'
  tagName: 'li'
  classNameBindings: ['content.tapped',':card']

  didInsertElement: ->
    @_super()
    @setup_ui ({
      scope: 'cards'
      stack: '.card'
      scroll: false
      revert: 'invalid'
      zIndex: 1000
      snapMode: 'inner'
     })
    @$().data('card',@get('content'))
    @$().data('container',@get('holder'))

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
}
