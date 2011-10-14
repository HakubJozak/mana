class HandView extends FloatingBrowser

  @tagName: 'div'
  @className: 'hand'

  @bind_controls: (user) ->
    create = ->
      view = new HandView({ model: user.hand });

    Controls.current.bind 'key:spacebar', create
    $('#battlefield').click _.wrap( create, _.preventer)
    $('#battlefield').bind('contextmenu', _.wrap( create, _.preventer))


  constructor: (attrs) ->
    super(attrs)

    $('body').append(@el)
    @el.disableSelection()
    @el.draggable()
    @el.droppable
      accept: @_accept_unless_in
      scope: 'cards'
      greedy: true
      hoverClass: 'card-over'
      drop: @dropped

    @render()

  create_card_view: (card) =>
    new CardView(model: card)

  append_card_view: (view) =>
    @el.find('.container').append(view.el)

  render: =>
    _.each @views, (view, i) => view.render()
    @el.fadeIn()
    this



window.HandView = HandView