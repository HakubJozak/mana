class BattlefieldView extends CardCollectionView

  @tagName: 'table'
  @className: 'battlefield'

  constructor: (attrs) ->
    super(attrs)
    BattlefieldView.instance = this
    @el = $('#battlefield')
    @remote_part = _.template($('#battlefield-remote-part-template tbody').html())
    @local_part = _.template($('#battlefield-local-part-template tbody').html())
    @render()

  tap_a_row: () =>

  # REFACTOR this god method?
  create_user_part: (user) =>
    if user.local
      part = $(@local_part(user.toJSON()))
      $('#battlefield tbody.local').append(part)
    else
      part = $(@remote_part(user.toJSON()))
      $('#battlefield tbody.remote').append(part)

    part.bind 'contextmenu', (e) =>
      $(e.target).parent('tr').find('td .card').each (i,card) =>
        $(card).data('game-object').model.toggle_tapped()
        true

      e.stopPropagation();
      e.preventDefault();


    part.find('td').droppable
      scope: 'cards'
      hoverClass: 'card-over'
      drop: @dropped
      accept: (draggable) ->
        if ($('.hand.card-over').length < 1) && draggable.hasClass('card')
          return true
        else
          $('td.card-over').removeClass('card-over')
          return false

  create_card_view: (card) =>
    new CardViewBattlefield(model: card)

  append_card_view: (view) =>
    td = @$("##{view.model.position()}")
    td.append(view.el)
    view.stack_in_cell()
    # 'moving' is delayed so that the drop does not
    #  cause a confusing effect on local
    # revive = () => view.el.addClass('moving')
    # window.setTimeout(revive, 300)

  sort: =>
    # do it better

  dropped: (event,ui) =>
    cell = $(event.target)
    card = ui.draggable.ob().model
    @model.put_on_position( card, cell.attr('id'))


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

  visible: =>  !@model.covered()

  stack_in_cell: =>
    y = @model.get('order') * 25
    @el.css('position','absolute')

    if @model.tapped()
      @el.css('top',"0px")
      @el.css('left',"-#{y}px")
    else
      if @el.parents('tbody.remote').length > 0
        # remote cards are stacked up-side-down
        @el.css('top',"-#{y}px")
      else
        @el.css('top',"#{y}px")

    @el.css('z-index',y)

  render: =>
    super()


window.CardViewBattlefield = CardViewBattlefield
window.BattlefieldView = BattlefieldView