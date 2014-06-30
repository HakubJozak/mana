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
    console.info 'i got called'
    @_super()

  after_drop: (card) ->
    if @get('name') == 'deck'
      card.set('covered',true)
}
