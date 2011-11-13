class CardBrowser extends CardCollectionView

  @all: {}

  @show_or_hide: (model) =>
    all = CardBrowser.all

    if all[model.id]?
      all[model.id].remove()
    else
      all[model.id] = new CardBrowser(model: model)

  constructor: (params) ->
    super(params)

    $('body').append(@el)
    @el.disableSelection()
    @el.data('game-object', @model)

    @el.draggable
      scope: 'decks',
      containment: 'body',
      handle: 'h2'

    @el.droppable
      scope: 'cards'
      greedy: true
      hoverClass: 'card-over'
      drop: @dropped

    @$('.close-button').click =>
      @remove()

    @$('.shuffle-button').click =>
      @model.shuffle()

    @box = @$('.container')
    @render()
    Message.action "is browsing #{@model.long_title}."

  remove: =>
    after = () =>
      @model.unbind 'add', @add_card_view
      @model.unbind 'remove', @remove_card_view
      @model.unbind 'change', @render
      @el.remove()
      CardBrowser.all[@model.id] = null

    @el.fadeOut('200', after)

  create_card_view: (card) =>
    new CardViewBrowser(model: card)

  append_card_view: (view) =>
    @box.prepend(view.el)

  render: =>
    super()
    @el.appendTo('body')
    @el.fadeIn()

class CardViewBrowser extends CardView

  show_image: =>
    @img.attr('src',@model.image())

  show_tapping: =>
    $(@el).removeClass('tapped')



window.CardBrowser = CardBrowser
window.CardViewBrowser = CardViewBrowser