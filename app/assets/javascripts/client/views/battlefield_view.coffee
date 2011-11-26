class BattlefieldView extends CardCollectionView

  @tagName: 'table'
  @className: 'battlefield'

  constructor: (attrs) ->
    super(attrs)

    @el = $('#battlefield')
    @$('tr.active td').droppable
      scope: 'cards'
      hoverClass: 'card-over'
      drop: @dropped
#      accept: (draggable) ->
#        ($('.card-over' ).length < 2) && draggable.hasClass('card');

    @render()

  create_card_view: (card) =>
    new CardViewBattlefield(model: card)

  append_card_view: (view) =>
    @el.append(view.el)
    # 'moving' is delayes, so that the drop does not
    #  a cause confusing effect on local
    revive = () => view.el.addClass('moving')
    window.setTimeout(revive, 300)


  sort: =>
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

  constructor: (params) ->
    super(params)
    @el.bind 'contextmenu', @tap_untap
    @add_menu_item 'transform-button', 'Transform', 'Transform card (r)', => @model.transform()
    @add_menu_item 'cover-button', 'Un|cover', 'Cover/Uncover the card (u)', => @model.toggle_covered()
    @add_menu_item 'detail-button', 'Detail', 'Show detail of the card', => @show_detail()
    @add_menu_item 'bottom-button', 'Bottom', 'Put the card to the bottom of your library', => @model.put_to_bottom()

  tap_untap: (e) =>
    e.preventDefault()
    e.stopPropagation()
    @model.toggle_tapped()

    # TODO: put elsewhere!
    if @model.covered()
      Message.action "is tapping a card."
    else
      Message.action "is tapping '#{@model.name()}'."

  visible: =>  !@model.covered()

  render: =>
    super()

    @el.css('position','absolute')
    pos = @model.position()
    @el.css({ left: pos.x, top: pos.y })

window.CardViewBattlefield = CardViewBattlefield
window.BattlefieldView = BattlefieldView