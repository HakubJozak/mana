class CardCollection extends Backbone.Collection
  model : Card

  @all: {}

  constructor: (@name, @player, cards = null) ->
    super(cards)
    throw 'Name of the CardCollection missing' unless @name?

    @title = "#{Utils.camelize(@name)}"
    # TODO: legacy - remove
    @user = @player

    if @player
      @id = "#{@name}-#{@player.id}"
      @long_title = "#{@player.name()}'s #{@title}"
    else
      @id = @name
      @long_title = @title

    CardCollection.all[@id] = this

  add_on_top: (card) =>
    top = @last()? && @last().order() + 1
    @add_card_with_order( card, top)

  put_to_bottom: (card) =>
    card.set({ transformed: false }, { silent: true} )
    bottom = @first()? && @first().order() - 1
    @add_card_with_order( card, bottom)

  # private
  add_card_with_order: (card, order) =>
    card.collection.remove(card)
    # TODO: card#reset()
    card.set({ order: order || 1, tapped: false, counters: null, toughness: null, power: null }, { silent: true} )
    @add(card)
    card.save()

  comparator: (card) ->
    card.order()

  public: =>
    (@name != 'library') and (@name != 'hand')

  shuffle_cards: =>
    Action.shuffle(this).save()

window.CardCollection = CardCollection
new CardCollection('exile')

