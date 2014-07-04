# -*- tab-width: 2; -*-

Mana.CardView = Ember.View.extend Mana.Draggable, {
  templateName: 'card'
  tagName: 'li'
  classNameBindings: ['content.tapped',':card']
  backImage: window.image_path('back.jpg')

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
      card.flip()

  click: (event) ->
    card = @get('content')
    if event.which == 2
      card.tap()
    else
      @get('controller').transitionToRoute("detail", card)
}
