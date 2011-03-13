class User extends Backbone.Model

  constructor: (params) ->
    super(params)

    # set the local flag and clean it
    if params.local
      User.local = this
      @unset('local',{ silent: true })
      @local = true

    @set({ lives: 20 })
    # TODO: DRY
    @library = new CardCollection("library-#{@id}",'Library', params.cards)
    @graveyard = new CardCollection("graveyard-#{@id}",'Graveyard')
    @exile = new CardCollection("exile-#{@id}", 'Exile')
    @hand = new Hand({ user: this })

  lives: => @get('lives')
  name: => @get('name')

class UserCollection extends Backbone.Collection
  model : User

User.all = new UserCollection()
