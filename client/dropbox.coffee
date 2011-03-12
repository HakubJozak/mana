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

  dropped: (event,ui) =>
    card = ui.draggable.ob().model
    card.move_to(@model)
    card.save()

  render: =>
    @model.each (card) =>
      view = CardView.find_or_create(card)
      view.el.offset({ top: @box.offset().top + 5, left: @box.offset().left + 5 })
      view.render()
