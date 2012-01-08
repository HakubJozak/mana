class CardDetailView extends Backbone.View

  constructor: (attrs) ->
    super(attrs)
    @position = attrs.position
    @template = _.template($('#card-detail-template').html())
    @render()

    @$('.close-button').click @close

  render: =>
    @el = $(@template(@model.toJSON()))
    @el.css('position', 'absolute')
       .css('top',  @position.top)
       .css('left', @position.left)
       .appendTo('body')
       .draggable(start: @disable_close)

    w = @el.width() * 2
    h = @el.height() * 2

    @el.animate({ width: "#{w}px", height: "#{h}px", top: "#{@position.top - 50}px", left: "#{@position.left - 50}px" }, @on_animation_end)
    @el.find('.info-link').show() if @model.url()?
    console.info this

   close: =>
      @el.fadeOut =>
        @el.remove()

   disable_close: =>
     # HACK: prevents the detail to be closed after dragging.
     @ignore_click = true

   on_animation_end: =>
     @$('img').click (e) =>
       if @ignore_click
         @ignore_click = false
       else
         @close()
       true


window.CardDetailView = CardDetailView
