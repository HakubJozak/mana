class CardBrowser extends CardCollectionView

  @HTML = """
           <div class='overlay-container'>
             <div class='card-browser'>
               <div class='handle'>
                 <h1>{{title}}</h1>
                 <span class='close-button button'>x</span>
               </div>
               <div class='container'></div>
             </div>
           </div>
          """


  constructor: (params) ->
    super(params)

    @el = $($.mustache(CardBrowser.HTML, @model))
    @el.appendTo('body')

    @el.disableSelection()
    @el.data('game-object', @model)
    @$('.close-button').click @close

    @box = @$('.container')
    @render()
    Message.action "is browsing #{@model.long_title}."

  create_card_view: (card) =>
    view = new CardViewBrowser(model: card)
    view

  append_card_view: (view) =>
    @box.prepend(view.el)

  close: =>
    @el.remove()

  render: =>
    super()
    @sort()



class CardViewBrowser extends CardView

  constructor: (params) ->
    params['template'] = '#card-view-browser-template'
    super(params)
    @el.bind 'contextmenu', @show_menu
    @add_menu_item 'detail-button', 'Detail', 'Show detail of the card', => @show_detail()
    @add_menu_item 'to-hand-button', 'Hand', 'Put the card to your hand', => @model.put_to_hand()
    @add_menu_item 'battlefield-button', 'Battlefield', 'Put the card on the battlefield', => @model.put_on_battlefield()

  visible: -> true

  show_image: =>
    @img.attr('src',@model.image())

  show_tapping: =>
    $(@el).removeClass('tapped')


window.CardBrowser = CardBrowser
window.CardViewBrowser = CardViewBrowser