class User extends Backbone.Model

  constructor: (params) ->
    @library = new Library(params.cards)
    @graveyard = new Dropbox()
    @exile = new Dropbox()
    # _.each(params.cards) (c) ->
    #   card = new Card(c)
    #   view = new CardView({ model: card })


class UserCollection extends Backbone.Collection
  model : User

  constructor: ->
    super

User.all = new UserCollection()

