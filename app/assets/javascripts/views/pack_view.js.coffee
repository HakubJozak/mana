Mana.PackView = Ember.View.extend Mana.DroppableForCard, {
  tagName: 'div'
  classNames: [ 'pile-container' ]
  templateName: 'pack'

  # jQuery UI
  scope: 'cards'
  hoverClass: 'card-over'
  greedy: true
  addClasses: true
  tolerance: 'pointer'

  init: ->
    @_super()
    @get('holder').addObserver 'top', =>
      @rerender()

  after_drop: (card) ->
    if @get('name') == 'deck'
      card.set('covered',true)
}
