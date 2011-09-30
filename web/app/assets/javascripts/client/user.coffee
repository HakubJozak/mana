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
    @library = new CardCollection(@id, 'library', params.cards)
    @graveyard = new CardCollection(@id, 'graveyard')
    @exile = new CardCollection(@id, 'exile')
    @hand = new Hand({ user: this })

  lives: => @get('lives')
  color: => @get('color')
  name: => @get('name')

class UserCollection extends Backbone.Collection
  model : User

User.all = new UserCollection()

window.User = User
window.UserCollection = UserCollection