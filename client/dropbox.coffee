class Dropbox extends CardCollectionView

  @tagName: 'div'
  @className: 'box'

  constructor: (attrs) ->
    super(attrs)
    @box = @el.find('.box')
    @box.droppable
      accept: @_accept_unless_in
      scope: 'cards'
      greedy: true
      hoverClass: 'card-over'
      drop: @dropped


  tappingAllowed: -> false

  render: =>
    @model.each (card) =>
      el = CardView.find_or_create(card).render().el
      # TODO: DRY and optimize
      @_attach_card(el)
      el.offset({ top: @box.offset().top + 5, left: @box.offset().left + 5 })
      this