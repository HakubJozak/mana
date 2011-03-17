class CardBrowser extends FloatingBrowser

  constructor: (params) ->
    super(params)
    @dropbox = params.dropbox

    @$('.close-button').click =>
      @toggle_visible()
      @dropbox.toggle_visible()

    @$('.uncover-button').click =>
      @model.each (card) -> card.toggle_covered(false, { save: false })

    @$('.cover-button').click =>
      @model.each (card) -> card.toggle_covered(true, { save: false })


  _render_if_visible: (width = 950) =>
    padding = 10;
    h_start = 35;
    w_per_card = CARD_W + padding
    h_per_card = CARD_H + padding
    columns = Math.floor(width / w_per_card)
    @el.css('width', width)

    @model.each (card, i) =>
      view = CardView.find_or_create(card)
      x = Math.floor(i % columns)
      y = Math.floor(i / columns)
      position = @el.offset()

      view.el.detach()
      view.el.appendTo(@el)
      view.el.offset
        top: position.top + h_start + padding + y * h_per_card
        left: position.left + padding + w_per_card * x

      @el.css('height', h_start + (y+1) * h_per_card)
