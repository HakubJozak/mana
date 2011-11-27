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

  create_user_part: (user) =>
    if user.local
      part = $(@local_part(user.toJSON()))
      $('#battlefield tbody.local').append(part)
    else
      part = $(@remote_part(user.toJSON()))
      $('#battlefield tbody.remote').append(part)

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
    @$("##{view.model.position()}").append(view.el)
    # 'moving' is delayed so that the drop does not
    #  cause a confusing effect on local
    revive = () => view.el.addClass('moving')
    window.setTimeout(revive, 300)

  sort: =>
    # do it better

  dropped: (event,ui) =>
    console.info 'dropped'
    cell = $(event.target)
    card = ui.draggable.ob().model
    old = card.collection
    card.set({ position: cell.attr('id') }, { silent: true })

#    unless old.id == @model.id
    old.remove(card)
    @model.add(card)

    card.save()



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
#    @el.css('position','absolute')
    @el.css('top','0px').css('left','0px')
#    @el.appendTo("##{@model.position()}")


window.CardViewBattlefield = CardViewBattlefield
window.BattlefieldView = BattlefieldView