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

  add_on_top: (card) =>
    card.collection.remove(card)

    order = if @last()
              @last().order() + 10
            else
              1

    card.set({ order: order }, { silent: true} )
    @add(card)
    card.save()


  put_to_bottom: (card) =>
    card.collection.remove(card)

    order = if @first()
              @first().order() - 10
            else
              1

    card.set({ order: order }, { silent: true} )
    @add(card)
    card.save()

  comparator: (card) ->
    card.order()

  shuffle_cards: =>
    old = @comparator
    @models = _.shuffle(@models)
    @each (card,i) ->
      card.set(order: i*10)
      card.save()

window.CardCollection = CardCollection