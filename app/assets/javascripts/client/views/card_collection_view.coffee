class CardCollectionView extends Backbone.View

  @all: {}

  constructor: (attrs) ->
    super(attrs)
    throw 'Missing model' unless @model
    CardCollectionView.all[@model.id] = this

    clazz = @constructor.name.toLowerCase()
    tmpl = $("##{clazz}-template")

    if tmpl.length > 0
      @template = _.template(tmpl.html())
      @el = $(@template(@model))

    @views = []

    @model.bind 'add', @add_card_view
    @model.bind 'remove', @remove_card_view
    @model.each (card) => @add_card_view(card)

  _accept_unless_in: (card)  =>
    true

  create_card_view: (card) =>
    new CardView(model: card, this)

  add_card_view: (card) =>
    view = @create_card_view(card)
    @views.push(view)
    @append_card_view(view)
    view.render()

  append_card_view: ->
    throw 'Implement append_card_view method!'

  remove_card_view: (card) =>
    view = _(@views).select (v) -> v.model.id == card.id
    view = view[0]
    @views = _(@views).without(view);
    view.el.remove()

  dropped: (event,ui) =>
    card = ui.draggable.ob().model
    card.collection.remove(card)
    @model.add(card)
    card.save()

window.CardCollectionView = CardCollectionView