class HandView extends CardCollectionView

  @tagName: 'div'
  @className: 'hand'

  @bind_controls: (user) ->
    create_or_close = ->
      if HandView.current?
        HandView.current.close()
      else
        HandView.current = new HandView({ model: user.hand });
        HandView.current.el.offset(HandView.last_position) if HandView.last_position?
        HandView.current.el.fadeIn()

    Controls.current.bind 'key:spacebar', create_or_close
    $('#battlefield').click _.wrap( create_or_close, _.preventer)
    $('#battlefield').bind('contextmenu', _.wrap( create_or_close, _.preventer))


  constructor: (attrs) ->
    super(attrs)

    $('body').append(@el)
    @el.disableSelection()

    @el.draggable
      scope: 'decks',

    @el.droppable
      accept: @_accept_unless_in
      scope: 'cards'
      greedy: true
      hoverClass: 'card-over'
      drop: @drop_and_turn

    @el.data('game-object', @model)
    @render()
    @$('.close-button').click(@close)
    @$('.mulligan-button').click(@mulligan)

  close: =>
    if User.local is @model.user
      HandView.last_position = @el.offset()
      HandView.current = null

    @el.fadeOut => @el.remove()

  create_card_view: (card) =>
    new CardView(model: card)

  append_card_view: (view) =>
    @el.find('.container').append(view.el)

  drop_and_turn: (event,ui) =>
    card = ui.draggable.ob().model
    card.collection.remove(card)
    @model.add(card)
    card.set(covered: false, {silent: true})
    card.save()

  render: =>
    super()
    _.each @views, (view, i) => view.render()
    @el.fadeIn()
    this

  mulligan: =>
    if confirm('Do you really want to mulligan?')
      @model.mulligan()


window.HandView = HandView