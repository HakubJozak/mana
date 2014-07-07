Mana.HandView = Ember.View.extend  Mana.DroppableForCard, {
  templateName: 'hand'
  tagName: 'div'
  classNames: [ 'hand' ]

  scope: 'cards'
  hoverClass: 'card-over'
  greedy: true
  addClasses: true
  # intersect does not work because absolute position of the draggable
  # is not really absolute, but relative to it's starting point (?ORLY)
  tolerance: 'pointer'
}


Mana.HandView.CardView = Ember.View.extend Mana.Draggable, {
  tagName: 'div'
  classNames: [ 'slot hand-card card' ]

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

  click: (event) ->
    card = @get('content')
    @get('controller').transitionToRoute("detail", card)
    event.preventDefault()

  # start: ->
  accepted: (slot) ->
    console.debug "accepted in #{slot}"

  stop: ->
}
