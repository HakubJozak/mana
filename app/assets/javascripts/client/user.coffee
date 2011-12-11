class User extends Backbone.Model

  constructor: (params) ->
    super(params)

    # set the local flag and clean it so that it does not spread on save()
    if params.local
      User.local = this
      @unset('local',{ silent: true })
      @local = true

    @set({ lives: 20 })
    # TODO: DRY
    @library = new CardCollection( 'library',  this)
    @graveyard = new CardCollection( 'graveyard',  this)
    @hand = new Hand( 'hand',  this)

  spectator: => @get('spectator')
  connected: => @get('connected')
  lives: => @get('lives')
  color: => @get('color')
  name: => @get('name')
  id: => @get('_id')


class UserCollection extends Backbone.Collection
  model : User

User.all = new UserCollection()

window.User = User
window.UserCollection = UserCollection