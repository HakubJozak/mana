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

  shuffle_cards: =>
    old = @comparator
    @models = _.shuffle(@models)
    @each (card,i) ->
      card.set(order: i*10)
      card.save()

window.CardCollection = CardCollection