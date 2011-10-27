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

    @model.bind 'add', @add_card_view
    @model.bind 'remove', @remove_card_view
    @model.bind 'change', @sort

  _accept_unless_in: (card)  =>
    true

  create_card_view: (card) =>
    new CardView(model: card, this)

  add_card_view: (card) =>
    view = @create_card_view(card)
    @views.push(view)
    @append_card_view(view)
    view.render()
    @sort()

  sort: =>
    @views = _(@views).sortBy (view) -> view.model.order()
    _(@views).each (view) =>
      view.el.detach()
      @append_card_view(view)

  render: =>
    unless @views?
      @views = []
      @model.each (card) => @add_card_view(card)
#      reversed = @model.models.slice(0).reverse()
#      _(reversed).each (card) => @add_card_view(card)

  append_card_view: ->
    throw 'Implement append_card_view method!'

  remove_card_view: (card) =>
    view = _(@views).select (v) -> v.model.id == card.id
    view = view[0]
    @views = _(@views).without(view);
    view.el.remove()
    @sort()

  dropped: (event,ui) =>
    card = ui.draggable.ob().model
    card.collection.remove(card)

    order = if @model.last()
              @model.last().order() + 1
            else
              1

    card.set({ order: order }, { silent: true} )
    @model.add(card)

    card.save()

window.CardCollectionView = CardCollectionView