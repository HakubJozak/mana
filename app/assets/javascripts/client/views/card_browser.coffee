class CardBrowser extends CardCollectionView

  constructor: (params) ->
    super(params)

    $('body').append(@el)
    @el.disableSelection()
    @el.draggable()
    @el.droppable
      scope: 'cards'
      greedy: true
      hoverClass: 'card-over'
      drop: @dropped

    @$('.close-button').click =>
      @el.fadeOut()
      @el.remove()

    @$('.shuffle-button').click =>
      @model.shuffle()

    @$('.uncover-button').click =>
      @model.each (card) -> card.toggle_covered(false, { save: false })

    @$('.cover-button').click =>
      @model.each (card) -> card.toggle_covered(true, { save: false })

    @box = @$('.container')
    @render()


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