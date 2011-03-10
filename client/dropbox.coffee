class Dropbox extends Backbone.View

  @tagName: 'div'
  @className: 'box'

  constructor: (attrs) ->
    super(attrs)

    @model.bind 'add', @render
    @model.bind 'change', @render

    @template = _.template($('#dropbox-template').html())
    @el = $(@template({ name: @model.name }))
    @box = @el.find('.box')
    @box.droppable
      accept: @may_accept
      scope: 'cards'
      greedy: true
      hoverClass: 'card-over'
      drop: @dropped

  tappingAllowed: -> false

  may_accept: (card)  =>
    !@model.include(card.ob().model)

  dropped: (event,ui) =>
    card = ui.draggable.ob().model
    card.collection.remove(card)
    @model.add(card)

  render: =>
    if card = @model.first()
      dom = $("#card-#{card.id}")

      if dom.length > 0
        console.info dom
        view = dom.ob()
      else
        console.info 'not found'
        view = new CardView({ model: @model.first() })
        view.el.css('position','absolute')
        $('body').append(view.el)

      view.el.offset({ top: @box.offset().top + 5, left: @box.offset().left + 5 })
      view.render()
