class CardCollectionView extends Backbone.View

  constructor: (attrs) ->
    super(attrs)
    throw 'Missing model' unless @model

    clazz = @constructor.name.toLowerCase()
    @template = _.template($("##{clazz}-template").html())
    @el = $(@template(@model))

    @model.bind 'add', @render
    @model.bind 'remove', @render
    @model.bind 'refresh', @render

  _accept_unless_in: (card)  =>
    !@model.include(card.ob().model)

  dropped: (event,ui) =>
    console.info ui.draggable
    card = ui.draggable.ob().model
    card.move_to(@model, { order: 'last' })
    card.save()

  toggle_visible: =>
    @visible = !@visible
    @render()

  render: =>
    views = @model.map (card) -> CardView.find_or_create(card)

    _.each views, (card, i) =>
      card.el.detach()
      card.el.appendTo(@el)

    if @visible
      @el.fadeIn()
      @_render_if_visible()
    else
      @el.fadeOut()

    this
