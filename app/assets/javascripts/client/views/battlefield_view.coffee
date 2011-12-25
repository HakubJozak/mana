class BattlefieldView extends CardCollectionView

  initialize: (attrs) ->
    @player = attrs.player
    @create_user_part(@player)
    @render()

  tap_a_row: (event) =>
    $(event.target).parent('tr').find('td .card').each (i,card) =>
      $(card).data('game-object').model.toggle_tapped()
      true

  # REFACTOR this god method?
  create_user_part: (player) =>
    @el = @build_part(player)

    @el.bind 'contextmenu', _.preventing_wrap(@tap_a_row)

    @el.find('td').droppable
      scope: 'cards'
      hoverClass: 'card-over'
      drop: @dropped
      accept: (draggable) ->
        if ($('.hand.card-over').length < 1) && draggable.hasClass('card')
          return true
        else
          $('td.card-over').removeClass('card-over')
          return false

    # TODO: separate to its own View
    #------ MENU --------
    menu = """
            <ol class='battlefield-menu'
                id='battlefield-menu-#{player.id}'
                style='display:none'
                >
              <li>+</li>
              <li>-</li>
            </ol>
           """
    tmpl = _.template(menu)
    menu = $(tmpl(player: player))
    $('body').append(menu)
    menu.position(@el.position)
    #-------------------


  build_part: (player) =>
    settings = player.get 'settings'
    rows = settings.rows
    cols = settings.cols

    card_w = ($('#battlefield').width() / cols) - 10
    card_h = card_w * 1.4
    id = "battlefield-part-#{player.id}"
    tbody = $("<table><tbody id='#{id}'></tbody></table>")

    for y in [1..rows]
      tr = $('<tr></tr>')

      for x in [1..cols]
        td = "<td id='grid-#{x}-#{y}-#{player.id}'></td>"
        tr.append(td)

      tbody.append(tr)

    style = """
              <style>
                #battlefield tbody##{id} .card,
                #battlefield tbody##{id} .card img {
                width: #{card_w}px;
                height: #{card_h - 10}px;
               }
               </style>
            """

    tbody.append(style)

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
    true

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
      if @el.parents('.rotated').length > 0
        # remote cards are stacked up-side-down
        @el.css('top',"-#{y}px")
      else
        @el.css('top',"#{y}px")

    @el.css('z-index',y)

  render: =>
    super()


window.CardViewBattlefield = CardViewBattlefield
window.BattlefieldView = BattlefieldView