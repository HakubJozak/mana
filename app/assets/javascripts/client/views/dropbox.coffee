class Dropbox extends CardCollectionView

  @tagName: 'div'
  @className: 'box'

  constructor: (attrs) ->
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

    # TODO - DRY - abstract overlay
    @box.mouseenter =>
      @$('.overlay').fadeIn()

    @box.mouseleave =>
      @$('.overlay').fadeOut()


  _enable_browsing: =>
    @browser = new CardBrowser({ model: @model, dropbox: this })
    @$('.browse-button').click =>
      @browser.toggle_visible()
      @toggle_visible()

  tappingAllowed: -> false

#  render: =>
#    super
    #@$('.count').text(@model.length)

window.Dropbox = Dropbox