Mana.SlotView = Ember.CollectionView.extend Mana.Droppable, {
  tagName: 'ul'
  classNames: [ 'slot' ]
  itemViewClass: Mana.CardView
  emptyView: Ember.View.extend({
    template: Ember.Handlebars.compile("<img src='/assets/empty.png'>")
   })

  # jQuery UI properties
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
      console.debug card.get('id')
      console.debug card.get('position')
      console.debug card.get('location')
    # else
    #   console.debug 'drop fired without UI'


}
