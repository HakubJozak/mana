Mana.PileView = Ember.View.extend Mana.DroppableForCard,
  tagName: 'div'
  classNames: [ 'pile' ]
  templateName: 'pile'

  scope: 'cards'
  hoverClass: 'card-over'
  greedy: true
  addClasses: true
  tolerance: 'pointer'
