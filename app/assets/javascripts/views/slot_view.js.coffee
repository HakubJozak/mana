Mana.SlotView = Ember.CollectionView.extend Mana.DroppableForCard, {
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

  location_prefix: "battlefield"


  createChildView: (viewClass,attrs) ->
    attrs ||= {}
    attrs.holder = @get('content')
    return @_super(viewClass, attrs);

  after_drop: (card) ->
    # if it comes from hand, uncover it
    if card.get('location').indexOf('hand') == 0
      card.set('covered',false)

}
