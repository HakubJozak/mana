class User extends Backbone.Model

  constructor: (params) ->
    super(params)

    if @id == User.local_player_id
      User.local = this
      @local = true

    @set
      lives: 20
      settings:
        rows: 2
        cols: 8

    # TODO: DRY
    @library = new CardCollection( 'library', this)
    @graveyard = new CardCollection( 'graveyard', this)
    @battlefield = new Battlefield( 'battlefield', this, null)
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