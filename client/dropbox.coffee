class Dropbox extends CardCollectionView

  @tagName: 'div'
  @className: 'box'

  constructor: (attrs) ->
    super(attrs)

    @visible = true
    @_enable_browsing()
    @box = @el.find('.box')
    @box.droppable
      accept: @_accept_unless_in
      scope: 'cards'
      greedy: true
      hoverClass: 'card-over'
      drop: @dropped

  _enable_browsing: =>
    @browser = new CardBrowser({ model: @model, dropbox: this })
    @$('.browse-button').click =>
      @browser.toggle_visible()
      @toggle_visible()

  tappingAllowed: -> false

  _render_if_visible: =>
    @model.each (card) =>
      el = CardView.find_or_create(card).render().el
      # TODO: DRY and optimize
      el.detach()
      el.appendTo(@box)

      el.offset({ top: @box.offset().top + 5, left: @box.offset().left + 5 })
