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
#      greedy: true
      hoverClass: 'card-over'
      drop: @dropped

    @render()

    # TODO - DRY - abstract overlay
    @box.mouseenter =>
      @$('.overlay').fadeIn()

    @box.mouseleave =>
      @$('.overlay').fadeOut()

    @$('.browse-button').click =>
      CardBrowser.show_or_hide(@model)

    @$('.shuffle-button').click =>
      @model.shuffle_cards()
      new Message(text: "Player #{User.local.name()} has shuffled #{@model.long_title}.").save()


  create_card_view: (card) =>
    new CardViewDropbox(model: card, this)

  append_card_view: (view) =>
    @box.append(view.el)
#    @box.prepend(view.el)

class CardViewDropbox extends CardView

  constructor: (params, @dropbox) ->
    super(params)

  render: =>
    super()
    @el.css('position','absolute')
    @el.offset({ top: @dropbox.box.offset().top + 5, left: @dropbox.box.offset().left + 5 })


window.Dropbox = Dropbox
window.CardViewDropbox = CardViewDropbox
