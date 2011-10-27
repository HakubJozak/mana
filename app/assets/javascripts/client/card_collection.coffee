class CardCollection extends Backbone.Collection
  model : Card

  @all: {}

  constructor: (@name, @user, cards = null) ->
    super(cards)
    throw 'Name of the CardCollection missing' unless @name?

    @title = "#{Utils.camelize(@name)}"

    if @user
      @id = "#{@name}-#{@user.id}"
      @long_title = "#{@user.name()}'s #{@title}"
    else
      @id = @name
      @long_title = @title

    CardCollection.all[@id] = this

  comparator: (card) ->
    card.order()

  shuffle: =>
    @comparator = (card) => Math.floor(Math.random() * (@length + 1))
    @sort()
    @comparator = null

window.CardCollection = CardCollection