class CardCollectionView extends Backbone.View

  constructor: (attrs, initialize = true) ->
    super(attrs)
    return unless initialize

    throw 'Missing model' unless @model

    clazz = @constructor.name.toLowerCase()
    @template = _.template($("##{clazz}-template").html())
    @el = $(@template(@model))

    @views = []

    @model.bind 'add', @add_card_view
    @model.bind 'remove', @remove_card_view
    @model.bind 'refresh', @render

    @model.each (card) => @add_view(card)

  _accept_unless_in: (card)  =>
    true

  add_card_view: (card) =>
    view = new CardViewDropbox(model: card, this)
    @views.push(view)
    # view.el.appendTo(@el) if @rendered
    if @rendered
      $('#desk').append(view.el)
      view.render()

  remove_card_view: (card) =>
    view = _(@views).select (v) -> v.model.id == card.id
    @views = _(@views).without(view[0]);
    view.el.remove() if @rendered

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

    _.each @views, (card, i) =>
      console.info "-- #{card.name}"
      $('#desk').append(view.el)
      card.render()

    console.info "Rendering collection #{@model.name} finished"
    @rendered = true
    this

window.CardCollectionView = CardCollectionView