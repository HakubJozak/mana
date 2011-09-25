class FloatingBrowser extends CardCollectionView

  constructor: (attrs) ->
    super(attrs)
    $('body').append(@el)
    @el.disableSelection()
    @el.draggable();
    @el.droppable
      accept: @_accept_unless_in
      scope: 'cards'
      greedy: true
      hoverClass: 'card-over'
      drop: @dropped

  toggle_visible: =>
    @visible = !@visible
    @render()

