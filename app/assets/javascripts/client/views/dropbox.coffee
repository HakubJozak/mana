class Dropbox extends CardCollectionView

  @tagName: 'div'
  @className: 'box'

  constructor: (attrs) ->
    super(attrs)

    @box = @$('.box')
    @box.css('position','relative')
    @box.droppable
      accept: @_accept_unless_in
      scope: 'cards'
      hoverClass: 'card-over'
      drop: @dropped

    @render()
    @model.bind 'change', @update_counter
    @model.bind 'add', @update_counter
    @model.bind 'remove', @update_counter

    @$('.browse-button').click =>
      CardBrowser.show_or_hide(@model)

    @$('.shuffle-button').click =>
      @model.shuffle_cards()
      Message.action "is shuffling #{@model.long_title}."

  update_counter: =>
    @$('.counter').text @model.size()

  create_card_view: (card) =>
    new CardViewDropbox(model: card, this)

  append_card_view: (view) =>
    @box.append(view.el)


class CardViewDropbox extends CardView

  constructor: (params, @dropbox) ->
    super(params)
    @add_menu_item 'bottom-button', 'Bottom', 'Put the card to the bottom of your library', => @model.put_to_bottom()
    @add_menu_item 'battlefield-button', 'Battlefield', 'Put the card on the battlefield', => @model.put_on_battlefield()

  render: =>
    super()
    @el.css('position','absolute')
    @el.offset
      top: @dropbox.box.offset().top + 5,
      left: @dropbox.box.offset().left + 5

  visible: =>  !@model.covered()

   # no tapping here

window.Dropbox = Dropbox
window.CardViewDropbox = CardViewDropbox
