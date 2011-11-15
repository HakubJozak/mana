class CardBrowser extends CardCollectionView

  @all: {}

  @show_or_hide: (model) =>
    all = CardBrowser.all
    all[model.id] ||= new CardBrowser(model: model)
    all[model.id].open()

  constructor: (params) ->
    super(params)
    @el.disableSelection()
    @el.data('game-object', @model)

    @el.droppable
      scope: 'cards'
      greedy: true
      hoverClass: 'card-over'
      drop: @dropped

    @el.dialog
      autoOpen: false
      modal: true
#      maxWidth: '80%'
#      maxHeight: '80%'
      position: 'center'
      width: '80%'
      height: '750'
      minHeight: '750'
      title: @model.long_title


    @box = @$('.container')
    @render()
    Message.action "is browsing #{@model.long_title}."

  open: =>
    @el.dialog('open')

    # after_fadeout = () =>
    #   @model.unbind 'add', @add_card_view
    #   @model.unbind 'remove', @remove_card_view
    #   @model.unbind 'change', @render
    #   @el.remove()
    #   CardBrowser.all[@model.id] = null
    # @el.fadeOut('200', after_fadeout)

  create_card_view: (card) =>
    view = new CardViewBrowser(model: card)
    view.el.draggable( "option", "containment", @el)
    view

  append_card_view: (view) =>
    @box.prepend(view.el)

  render: =>
    super()
    @sort()

class CardViewBrowser extends CardView

  constructor: (params) ->
    super(params)
    @el.bind 'contextmenu', @show_menu

  visible: -> true

  show_image: =>
    @img.attr('src',@model.image())

  show_tapping: =>
    $(@el).removeClass('tapped')



window.CardBrowser = CardBrowser
window.CardViewBrowser = CardViewBrowser