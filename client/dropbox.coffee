class Dropbox extends CardCollectionView

  @tagName: 'div'
  @className: 'box'

  constructor: (attrs) ->
    super(attrs)
    @box = @el.find('.box')
    @box.droppable
      accept: @may_accept
      scope: 'cards'
      greedy: true
      hoverClass: 'card-over'
      drop: @dropped


  tappingAllowed: -> false

  may_accept: (card)  =>
    !@model.include(card.ob().model)

  render: =>
    @model.each (card) =>
      el = CardView.find_or_create(card).render().el
      # TODO: DRY and optimize
      el.detach
      el.appendTo('body')
      el.offset({ top: @box.offset().top + 5, left: @box.offset().left + 5 })
      this