class HandView extends FloatingBrowser

  @tagName: 'div'
  @className: 'hand'

  constructor: (attrs) ->
    super(attrs)

    if @model.user.local
      @visible = true
      $('#battlefield').click @toggle_visible
      Controls.current.bind 'key:spacebar', @toggle_visible

  _render_if_visible: =>
    views = @model.map (card) -> CardView.find_or_create(card)

    padding = 10
    @el.css('width', (padding + CARD_W) * @model.length + 2*padding)
    _.each views, (card, i) =>
      card.el.detach()
      card.el.appendTo(@el)
      card.el.offset
       top: @el.offset().top + 40,
       left: padding + @el.offset().left + i * (padding + CARD_W),
