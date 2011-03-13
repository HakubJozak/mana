class HandView extends CardCollectionView

  @tagName: 'div'
  @className: 'hand'

  constructor: (attrs) ->
    super(attrs)
    $('body').append(@el)
    @el.disableSelection();
    @el.droppable( "option", "greedy", true );
    @el.draggable();

  render: ->
    if @model.user.local
      @el.fadeIn()
    else
      @el.fadeOut()
