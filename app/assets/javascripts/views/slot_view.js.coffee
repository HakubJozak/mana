Mana.SlotView = Ember.CollectionView.extend Mana.DroppableForCard, {
  tagName: 'ul'
  classNames: [ 'slot' ]

  # CollectionView props
  itemViewClass: Mana.CardView
  emptyView: Ember.View.extend({
    template: Ember.Handlebars.compile("<img src='#{image_path('empty.png')}'>")
   })

  # jQuery UI props
  scope: 'cards'
  hoverClass: 'card-over'
  greedy: true
  addClasses: true
  tolerance: 'pointer'

  createChildView: (viewClass,attrs) ->
    attrs ||= {}
    attrs.holder = @get('holder')
    return @_super(viewClass, attrs);

}
