Mana.PileView = Ember.View.extend Mana.DroppableForCard, Mana.Draggable,
  tagName: 'div'
  classNames: [ 'pile' ]
  templateName: 'pile'

  scope: 'cards'
  hoverClass: 'card-over'
  greedy: true
  addClasses: true
  tolerance: 'pointer'

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

    @$().data('card',@get('holder.top'))
    @$().data('container',@get('holder'))

  after_drop: (card) ->
    if @get('name') == 'deck'
      card.set('covered',true)
