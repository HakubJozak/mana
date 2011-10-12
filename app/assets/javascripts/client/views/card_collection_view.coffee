class CardCollectionView extends UpdatingCollectionView

  initialize: (attrs, initialize = true) ->
    super( childViewConstructor: CardView, childViewTagName: 'div')

    throw 'Missing model' unless @model

    clazz = @constructor.name.toLowerCase()
    @template = _.template($("##{clazz}-template").html())
    @el = $(@template(@model))

  _accept_unless_in: (card)  =>
    true

  dropped: (event,ui) =>
    card = ui.draggable.ob().model
    card.collection.remove(card)
    @model.add(card)
    card.save()


window.CardCollectionView = CardCollectionView