class CardCollection extends Backbone.Collection
  model : Card

  @all: []

  constructor: (@id, @name, params) ->
    super(params)
    CardCollection.all[@id] = this
    throw 'Name of the CardCollection missing' unless @name
    throw 'ID of the CardCollection missing' unless @id
    @trigger('add')

  comparator: (card) ->
    card.order()

  shuffle: =>
    @comparator = (card) => Math.floor(Math.random() * (@length + 1))
    @sort()
    @comparator = null

  visible: -> false