class CardCollectionView extends Backbone.View

  constructor: (attrs, initialize = true) ->
    super(attrs)
    return unless initialize

    throw 'Missing model' unless @model

    clazz = @constructor.name.toLowerCase()
    tmpl = $("##{clazz}-template")

    if tmpl.length > 0
      @template = _.template(tmpl.html())
      @el = $(@template(@model))

    @views = []

    @model.bind 'add', @add_card_view
    @model.bind 'remove', @remove_card_view

    @model.each (card) => @add_card_view(card)
    @render()

  _accept_unless_in: (card)  =>
    true

  create_card_view: (card) =>
    new CardView(model: card, this)

  add_card_view: (card) =>
    view = @create_card_view(card)
    @views.push(view)

    if @append_card_view?
      @append_card_view(view)
      view.render()
    else
      throw 'Implement append_card_view method!'

  remove_card_view: (card) =>
    view = _(@views).select (v) -> v.model.id == card.id
    view = view[0]
    @views = _(@views).without(view[0]);
    view.el.remove() if @rendered

  dropped: (event,ui) =>
    card = ui.draggable.ob().model
    card.collection.remove(card)
    @model.add(card)
    card.save()

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