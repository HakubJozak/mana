class HandView extends CardCollectionView

  @tagName: 'div'
  @className: 'hand'

  constructor: (attrs) ->
    super(attrs)
    $('body').append(@el)
    @el.disableSelection()
    @el.draggable();
    @el.droppable
      accept: @may_accept
      scope: 'cards'
      greedy: true
      hoverClass: 'card-over'
      drop: @dropped

    @tr = @el.find('table tr')

  render: =>
    if @model.user.local
      @el.fadeIn()
      @model.each (card) =>
        el = CardView.find_or_create(card).render().el
        # TODO: DRY and optimize
        # SPREAD
    else
      @el.fadeOut()

    this