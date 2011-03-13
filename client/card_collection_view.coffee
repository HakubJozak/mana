class CardCollectionView extends Backbone.View

  constructor: (attrs) ->
    super(attrs)
    throw 'Missing model' unless @model

    @model.bind 'add', @render
    @model.bind 'remove', @render

    clazz = @constructor.name.toLowerCase()
    @template = _.template($("##{clazz}-template").html())
    @el = $(@template(@model))

  _accept_unless_in: (card)  =>
    !@model.include(card.ob().model)

  _attach_card: (card_el) =>
    unless card_el.parent().tagName == 'body'
      card_el.detach
      card_el.appendTo('body')

  dropped: (event,ui) =>
    card = ui.draggable.ob().model
    card.move_to(@model)
    card.save()
