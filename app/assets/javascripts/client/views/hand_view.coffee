class HandView extends CardCollectionView

  @tagName: 'div'
  @className: 'hand'

  @bind_controls: (user) ->
    create_or_close = ->
      if HandView.current?
        HandView.current.el.fadeOut()
        HandView.last_position = HandView.current.el.offset()
        HandView.current.el.remove()
        HandView.current = null
      else
        HandView.current = new HandView({ model: user.hand });
        HandView.current.el.offset(HandView.last_position) if HandView.last_position

    Controls.current.bind 'key:spacebar', create_or_close
    $('#battlefield').click _.wrap( create_or_close, _.preventer)
    $('#battlefield').bind('contextmenu', _.wrap( create_or_close, _.preventer))


  constructor: (attrs) ->
    super(attrs)

    $('body').append(@el)
    @el.disableSelection()

    @el.draggable
      scope: 'decks',
      containment: 'body',

    @el.droppable
      accept: @_accept_unless_in
      scope: 'cards'
      greedy: true
      hoverClass: 'card-over'
      drop: @dropped

    @el.data('game-object', @model)
    @render()

  create_card_view: (card) =>
    new CardView(model: card)

  append_card_view: (view) =>
    @el.find('.container').append(view.el)

  render: =>
    super()
    _.each @views, (view, i) => view.render()
    @el.fadeIn()
    this



window.HandView = HandView