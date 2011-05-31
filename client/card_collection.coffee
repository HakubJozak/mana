class CardCollection extends Backbone.Collection
  model : Card

  @all: []

  constructor: (@user_id, @name, params) ->
    super(params)
    CardCollection.all[@user_id] = this
    throw 'Name of the CardCollection missing' unless @name
    throw 'User ID of the CardCollection missing' unless @user_id
    
    @title = Utils.camelize(@name)
    @trigger('add')

  comparator: (card) ->
    card.order()

  shuffle: =>
    @comparator = (card) => Math.floor(Math.random() * (@length + 1))
    @sort()
    @comparator = null

  visible: -> false