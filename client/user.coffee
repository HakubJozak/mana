class User extends Backbone.Model

  constructor: (params) ->
    super(params)
    @set({ lives: 20 })
    @library = new CardCollection('library', params.cards)
    @graveyard = new CardCollection('graveyard')
    @exile = new CardCollection('exile')

  lives: => @get('lives')


class UserCollection extends Backbone.Collection
  model : User

User.all = new UserCollection()
