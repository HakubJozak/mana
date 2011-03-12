class BattlefieldView extends Backbone.View

  @tagName: 'div'
  @className: 'battlefield'

  constructor: (attrs) ->
    super(attrs)
    @el = $('#battlefield')
    @el.droppable
      scope: 'cards'
      hoverClass: 'card-over'
      drop: @dropped

  dropped: (event,ui) =>
    p = ui.draggable.offset()
    card = ui.draggable.ob().model
    card.move_to(@model)
    card.set({ position: @to_relative(p) }, { silent: true })
    card.save()

  to_relative: (p) =>
    origin = @el.offset();
    top =  p.top - origin.top;
    left = p.left - origin.left;
    return { y: top, x: left }

  render: =>
    # @model.each (card) =>
    #   view = CardView.find_or_create(card)
    #   view.el.position({ top: card.y, left: card.x })
    #   view.render()
