class HandView extends CardCollectionView

  @tagName: 'div'
  @className: 'hand'

  constructor: (attrs) ->
    super(attrs)
    $('body').append(@el)
    @el.disableSelection()
    @el.draggable();
    @el.droppable
      accept: @_accept_unless_in
      scope: 'cards'
      greedy: true
      hoverClass: 'card-over'
      drop: @dropped

    @initialize_local() if @model.user.local

  initialize_local: =>
    @visible = true
    $('#battlefield').click @toggle_visible
    Controls.current.bind 'key:spacebar', @toggle_visible

  toggle_visible: =>
    @visible = !@visible
    @render()

  render: =>
    if @visible and @model.user.local
      @el.fadeIn()
    else
      @el.fadeOut()

    @_spread()
    this

  _spread: =>
    views = @model.map (card) -> CardView.find_or_create(card)

    padding = 10
    @el.css('width', (padding + CARD_W) * @model.length + 2*padding)
    _.each views, (card, i) =>
      card.el.detach()
      card.el.appendTo(@el)
      card.el.offset
       top: @el.offset().top + 30,
       left: padding + @el.offset().left + i * (padding + CARD_W),
