class Dropbox extends CardCollectionView

  @HTML = """
           <div class='box-container {{name}}-container'>
             <h4>
               {{title}}
               {{#shufflable}}
                 <span class='shuffle-button icon icon-shuffle' title='Shuffle' ></span>
               {{/shufflable}}

               {{#browsable}}
                 <span class='browse-button icon icon-browse' title='Browse' ></span>
               {{/browsable}}
             </h4>
             <div class='box {{name}}'>
               <div class='counter dropbox-overlay'>0</div>
             </div>
           </div>
          """

  @tagName: 'div'
  @className: 'box'

  constructor: (attrs) ->
    super(attrs)

    @el = $($.mustache(Dropbox.HTML, @model))
    @box = @$('.box')
    @box.css('position','relative')
    @box.droppable
      accept: @_accept_unless_in
      scope: 'cards'
      hoverClass: 'card-over'
      drop: @dropped

    @render()
    @model.bind 'change', @update_counter
    @model.bind 'add', @update_counter
    @model.player.bind('change:browsables', @render_buttons) if @model.player

    @$('.browse-button').click =>
      new CardBrowser(model: @model)

    @$('.shuffle-button').click =>
      @model.shuffle_cards()
      Message.action "is shuffling #{@model.long_title}."

  update_counter: =>
    @$('.counter').text @model.size()

  create_card_view: (card) =>
    new CardViewDropbox(model: card, this)

  append_card_view: (view) =>
    @box.append(view.el)

  render: =>
    super()
    @$('.overlay').text @model.size()


class CardViewDropbox extends CardView

  constructor: (params, @dropbox) ->
    super(params)
    @add_menu_item 'bottom-button', 'Bottom', 'Put the card to the bottom of your library', => @model.put_to_bottom()
    @add_menu_item 'battlefield-button', 'Battlefield', 'Put the card on the battlefield', => @model.put_on_battlefield()

    prevent_detail = =>
      @dragged = true

    @el.draggable
      position: 0
      scope: 'cards'
      snap: '.card'
      snapMode: 'inner'
      scroll: false
      revert: 'invalid'
      stop: prevent_detail
      containment: 'window'
      zIndex: 99999

  render: =>
    super()
    @el.css('position','absolute')
    @el.offset
      top: @dropbox.box.offset().top + 5,
      left: @dropbox.box.offset().left + 5

  visible: =>  !@model.covered()

   # no tapping here

window.Dropbox = Dropbox
window.CardViewDropbox = CardViewDropbox
