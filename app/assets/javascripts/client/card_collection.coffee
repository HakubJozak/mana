class CardCollection extends Backbone.Collection
  model : Card

  @all: {}

  constructor: (@name, @user, cards = null) ->
    super(cards)

    throw 'Name of the CardCollection missing' unless @name?
    throw 'CardCollection is missing user' unless @user?

    @id = "#{@name}-#{@user.id}"
    @title = Utils.camelize(@name)

    CardCollection.all[@id] = this

  comparator: (card) ->
    card.order()

  shuffle: =>
    @comparator = (card) => Math.floor(Math.random() * (@length + 1))
    @sort()
    @comparator = null

window.CardCollection = CardCollection