class CardCollection extends Backbone.Collection
  model : Card

  @all: []

  constructor: (@user_id, @name, params) ->
    super(params)
    throw 'Name of the CardCollection missing' unless @name
    throw 'User ID of the CardCollection missing' unless @user_id
    CardCollection.all[@id()] = this

    @title = Utils.camelize(@name)
    @trigger('add')

  id: =>
    "#{@name}-#{@user_id}"

  comparator: (card) ->
    card.order()

  shuffle: =>
    @comparator = (card) => Math.floor(Math.random() * (@length + 1))
    @sort()
    @comparator = null

window.CardCollection = CardCollection