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
      old_slot = ui.draggable.data('container')
      slot = @get('content')

      if card.get('location') == 'hand'
        card.set('covered',false)

      card.set('location','battlefield')
      card.set('position',@position)
      slot.pushObject(card)
      old_slot.removeObject(card)

      console.debug card.player_id

      # card.save();
      # card.save().then(transitionToPost).catch(failure);

    # else
    #   console.debug 'drop fired without UI'


}
