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
      greedy: true
      hoverClass: 'card-over'
      drop: @dropped

    # TODO - DRY - abstract overlay
    @box.mouseenter =>
      @$('.overlay').fadeIn()

    @box.mouseleave =>
      @$('.overlay').fadeOut()


  create_card_view: (card) =>
    new CardViewDropbox(model: card, this)

  append_card_view: (view) =>
    @box.append(view.el)

window.Dropbox = Dropbox