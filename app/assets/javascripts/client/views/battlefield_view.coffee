class BattlefieldView extends CardCollectionView

  initialize: (attrs) ->
    @player = attrs.player
    @player.bind 'change:settings', @on_resize

    id = "battlefield-part-#{@player.id}"
    @el = $("<div id='#{id}' class='battlefield-part'></div>")
    @el.append(@create_user_part(@player))

    # TODO: DRY!
    @id = "battlefield-part-#{@player.id}"
    addon = """
              <style>
                ##{@id} .card,
                ##{@id} .card img {
                  width: #{@card_w}px;
                  height: #{@card_h - 10}px;
               }
               </style>
               <ol class='battlefield-menu' style='' >
                  <li class='minus'>-</li>
                  <li class='plus'>+</li>
                  <li class='rotate'>&darr;</li>
              </ol>
            """
    @el.append(addon)

    if attrs.replace?
      attrs.replace.replaceWith(@el)
    else
      if @player.local
        $("#battlefield").append(@el)
      else
        $("#battlefield").prepend(@el)

    @$('.plus').click _.preventing_wrap(@zoom_in)
    @$('.minus').click _.preventing_wrap(@zoom_out)
    @$('.rotate').click _.preventing_wrap(@rotate)

    if Player.local && Player.local.show_rotated_battlefield(@player)
      @rotate()

    @render()

  tap_a_row: (event) =>
    $(event.target).parent('tr').find('td .card').each (i,card) =>
      $(card).data('game-object').model.toggle_tapped()
      true

  on_resize: =>
    if @player.settings().rows != @rows
      @player.unbind 'change:settings', @on_resize
      new BattlefieldView( model: @player.battlefield, player: @player, replace: @el )

  zoom_in: =>
    if @rows > 2
      @player.set(settings: { rows: @rows - 1, cols: @cols - 4 })
      @player.save()

  zoom_out: =>
    if @rows < 4
      @player.set(settings: { rows: @rows + 1, cols: @cols + 4 })
      @player.save()

  rotate: =>
    @$('tbody tr').reverse().each ->
      tr = $(this)
      parent = tr.parent()
      tr.detach().appendTo(parent)

    @$('tbody').toggleClass('rotated')

  # REFACTOR this god method?
  create_user_part: (player) =>
    part = @build_part(player)

    part.bind 'contextmenu', _.preventing_wrap(@tap_a_row)

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

    return part


  build_part: (player) =>
    settings = player.get 'settings'
    @rows = settings.rows
    @cols = settings.cols

    @card_w = ($('#battlefield').width() / @cols) - 10
    @card_h = @card_w * 1.4
    tbody = $("<table><tbody></tbody></table>")

    for y in [1..@rows]
      tr = $('<tr></tr>')

      for x in [1..@cols]
        td = "<td id='grid-#{x}-#{y}-#{player.id}'></td>"
        tr.append(td)

      tbody.append(tr)

    tbody

  create_card_view: (card) =>
    new CardViewBattlefield(model: card, battlefield: this)

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
    @battlefield = params.battlefield
    @el.bind 'contextmenu', @tap_untap
    @add_menu_item 'transform-button', 'Transform', 'Transform card (r)', => @model.transform()
    @add_menu_item 'cover-button', 'Un|cover', 'Cover/Uncover the card (u)', => @model.toggle_covered()
    @add_menu_item 'detail-button', 'Detail', 'Show detail of the card', => @show_detail()
    @add_menu_item 'bottom-button', 'Bottom', 'Put the card to the bottom of your library', => @model.put_to_bottom()

    prevent_detail = =>
      @dragged = true

    @el.draggable
      position: 0
      scope: 'cards'
      snap: '.card'
      snapMode: 'inner'
      scroll: false
      revert: 'invalid'
      stop: prevent_detail
      containment: 'window'
      zIndex: 99999


  tap_untap: (e) =>
    e.preventDefault()
    e.stopPropagation()
    @model.toggle_tapped()

  visible: =>  !@model.covered()

  stack_in_cell: =>
    y = @model.get('order') * @battlefield.card_h * 0.1
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

window.CardViewBattlefield = CardViewBattlefield
window.BattlefieldView = BattlefieldView