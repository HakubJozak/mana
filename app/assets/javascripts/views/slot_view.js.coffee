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


  createChildView: (viewClass,attrs) ->
    attrs ||= {}
    attrs.holder = @get('content')
    return @_super(viewClass, attrs);

  drop: (event,ui) ->
    if ui
      card = ui.draggable.data('card')
      before = ui.draggable.data('container')
      now = @get('content')

      if card.get('location') == 'hand'
        card.set('covered',false)

      card.set('location','battlefield')
      card.set('position',@position)
      before.removeObject(card)
      now.pushObject(card)

      card.save();
      # card.save().then(transitionToPost).catch(failure);

    # else
    #   console.debug 'drop fired without UI'


}
