class Dropbox extends CardCollectionView

  @tagName: 'div'
  @className: 'box'

  initialize: (attrs) ->
    super(attrs)

    @visible = true
    @_enable_browsing()

    @box = @$('.box')
    @box.css('position','relative')
    @box.droppable
      accept: @_accept_unless_in
      scope: 'cards'
      greedy: true
      hoverClass: 'card-over'
      drop: @dropped

    @card_views = []

    @model.each (card, i) =>
      @card_views.push(new CardView({ model: card, container: @box}))

  _enable_browsing: =>
    @browser = new CardBrowser({ model: @model, dropbox: this })
    @$('.browse-button').click =>
      @browser.toggle_visible()
      @toggle_visible()

  tappingAllowed: -> false

  _render_if_visible: =>
    @$('.count').text(@model.length)

    @each (card, i) =>
      el.css('position','relative')
      el.offset({ top: @box.offset().top + 5, left: @box.offset().left + 5 })


window.Dropbox = Dropbox