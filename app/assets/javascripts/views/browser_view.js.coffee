Mana.BrowserView = Ember.View.extend  Mana.Droppable, {
  templateName: 'browser'
  tagName: 'div'
  classNames: [ 'browser' ]

  scope: 'cards'
  hoverClass: 'card-over'
  greedy: true
  addClasses: true
  # intersect does not work because absolute position of the draggable
  # is not really absolute, but relative to it's starting point (?)
  tolerance: 'pointer'

  drop: (event,ui) ->
    if ui
      card = ui.draggable.data('card')
      before = ui.draggable.data('container')
      now = @get('holder')

      card.set('covered',true)
      card.set('location','hand')
      card.set('position',@position)

      before.removeObject(card)
      now.pushObject(card)


}


Mana.BrowserView.CardView = Ember.View.extend Mana.Draggable, {
  tagName: 'div'
  classNames: [ 'slot browser-card card' ]

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
    @$().data('container',@get('container'))

  # start: ->
  accepted: (slot) ->
    console.info "accepted in #{slot}"

  stop: ->
}
