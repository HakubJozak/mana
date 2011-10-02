class CardCollectionView extends Backbone.View

  constructor: (attrs, initialize = true) ->
    super(attrs)
    return unless initialize

    throw 'Missing model' unless @model

    clazz = @constructor.name.toLowerCase()
    @template = _.template($("##{clazz}-template").html())
    @el = $(@template(@model))

    @model.bind 'add', @render
    @model.bind 'remove', @render
    @model.bind 'refresh', @render

  _accept_unless_in: (card)  =>
    # !@model.include(card.ob().model)
    true

  dropped: (event,ui) =>
    card = ui.draggable.ob().model
    card.collection.remove(card)
    @model.add(card)
    card.save()

  toggle_visible: =>
    @visible = !@visible
    @render()

  render: =>
    console.info "Rendering collection #{@model.name}"
    views = @model.map (card) -> CardView.find_or_create(card)

    _.each views, (card, i) =>
      card.el.detach()
      card.el.appendTo(@el)
      card.render()

    if @visible
      @el.fadeIn()
      @_render_if_visible()
    else
      @el.fadeOut()

    console.info "Rendering collection #{@model.name} finished"
    this

window.CardCollectionView = CardCollectionView