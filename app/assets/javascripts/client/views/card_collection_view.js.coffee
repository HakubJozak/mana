class CardCollectionView extends Backbone.View

  constructor: (attrs) ->
    super(attrs)
    throw 'Missing model' unless @model

    clazz = @constructor.name.toLowerCase()
    tmpl = $("##{clazz}-template")

    if tmpl.length > 0
      @template = _.template(tmpl.html())
      @el = $(@template(@model))

    @model.bind 'add', @add_card_view
    @model.bind 'remove', @remove_card_view
    @model.bind 'change', @render

  _accept_unless_in: (card)  =>
    true

  create_card_view: (card) =>
    new CardView(model: card, this)

  add_card_view: (card) =>
    view = @create_card_view(card)
    @views.push(view)
    @append_card_view(view)
    view.render()
    @render()

  remove_card_view: (card) =>
    view = _(@views).select (v) -> v.model.id == card.id
    view = view[0]
    @views = _(@views).without(view);
    view.el.remove()
    @render()

  sort: =>
    _(@views).each (view) =>
      view.el.detach()

    @views = _(@views).sortBy (view) -> view.model.order()

    _(@views).each (view) =>
      @append_card_view(view)
      # HACK - remove - should be handled in subviews
      view.el.css('z-index', 1000 + view.model.order())

  render: =>
    if @views?
      @sort()
    else
      @views = []
      @model.each (card) => @add_card_view(card)

  append_card_view: ->
    throw 'Implement append_card_view method!'

  dropped: (event,ui) =>
    card = ui.draggable.ob().model
    @model.add_on_top(card)

window.CardCollectionView = CardCollectionView