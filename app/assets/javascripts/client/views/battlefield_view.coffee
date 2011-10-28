class BattlefieldView extends CardCollectionView

  @tagName: 'div'
  @className: 'battlefield'

  constructor: (attrs) ->
    super(attrs)

    @el = $('#battlefield')
    @el.droppable
      scope: 'cards'
      hoverClass: 'card-over'
      drop: @dropped
      accept: (draggable) ->
        ($('.card-over' ).length < 2) && draggable.hasClass('card');

    @render()

  create_card_view: (card) =>
    new CardViewBattlefield(model: card)

  append_card_view: (view) =>
    @el.append(view.el)

#  sort: =>
    # do it better

  dropped: (event,ui) =>
    p = ui.draggable.offset()
    card = ui.draggable.ob().model
    old = card.collection

    card.set({ position: @to_relative(p) }, { silent: true })

    unless old.id == @model.id
      old.remove(card)
      @model.add(card)

    card.save()

  to_global: (p) =>
    origin = @el.offset()
    return {
      top:  p.y + @el.offset().top,
      left: p.x + @el.offset().left
    }

  to_relative: (p) =>
    origin = @el.offset()
    top =  p.top - origin.top
    left = p.left - origin.left
    return { y: top, x: left }


class CardViewBattlefield extends CardView

  render: =>
    super()
    @el.css('position','absolute')
    pos = @model.position()
    @el.css({ left: pos.x, top: pos.y })

    # 'moving' is delayes, so that the drop does not
    #  a cause confusing effect on local
    revive = () => @el.addClass('moving')
    window.setTimeout(revive, 300)

window.CardViewBattlefield = CardViewBattlefield
window.BattlefieldView = BattlefieldView