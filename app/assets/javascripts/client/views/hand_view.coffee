class HandView extends CardCollectionView

  @tagName: 'div'
  @className: 'hand'

  @bind_controls: (user) ->
    # TODO: refactor this crap
    create_or_close = ->
      if HandView.current?
        HandView.last_position = HandView.current.el.offset()
        HandView.current.close()
        HandView.current = null
      else
        HandView.current = new HandView({ model: user.hand });
        HandView.current.el.fadeIn()

        if HandView.last_position?
          console.info HandView.last_position
          HandView.current.el
                  .css('top',HandView.last_position.top + 'px')
                  .css('left',HandView.last_position.left + 'px')

    Controls.current.bind 'hand:show', create_or_close

  constructor: (attrs) ->
    super(attrs)

    $('body').append(@el)
    @el.disableSelection()

    @el.resizable
    @el.draggable
      scope: 'decks',

    @el.droppable
      accept: @_accept_unless_in
      scope: 'cards'
      greedy: false
      hoverClass: 'card-over'
      drop: @drop_and_turn

    @el.data('game-object', @model)
    @render()
    @$('.close-button').click(@close)
    @$('.mulligan-button').click(@mulligan)

  close: =>
    @el.fadeOut => @el.remove()

  create_card_view: (card) =>
    new CardViewHand(model: card)

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


class CardViewHand extends CardView

  constructor: (params, @dropbox) ->
    super(params)

  visible: => true


window.CardViewHand = CardViewHand
window.HandView = HandView