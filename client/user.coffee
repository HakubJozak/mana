class User extends Backbone.Model

  constructor: (params) ->
    super(params)
    @set({ lives: 20 })
    @library = new CardCollection("library-#{@id}",'Library', params.cards)
    @graveyard = new CardCollection("graveyard-#{@id}",'Graveyard')
    @exile = new CardCollection("exile-#{@id}", 'Exile')

  lives: => @get('lives')


class UserCollection extends Backbone.Collection
  model : User

User.all = new UserCollection()
