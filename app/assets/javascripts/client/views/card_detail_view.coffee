class CardDetailView extends Backbone.View

  constructor: (attrs) ->
    super(attrs)
    @position = attrs.position
    @template = _.template($('#card-detail-template').html())
    @render()

  render: =>
    @el = $(@template(@model.toJSON()))
    @el.css('position', 'absolute')
       .css('top',  @position.top)
       .css('left', @position.left)
       .appendTo('body')
       .draggable()

    w = @el.width() * 2
    h = @el.height() * 2

    @el.animate({ width: "#{w}px", height: "#{h}px", top: "#{@position.top - 50}px", left: "#{@position.left - 50}px" }, @on_animation_end)

   on_animation_end: =>
#     @$('ul.menu').css('display','block')
     @el.click =>
       @el.fadeOut =>
        @el.remove()


window.CardDetailView = CardDetailView
