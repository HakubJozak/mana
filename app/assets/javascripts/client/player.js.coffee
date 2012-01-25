class Player extends Backbone.Model

  constructor: (params) ->
    super(params)

    if @id == User.local_player_id
      User.local = this
      @local = true

    @library = new CardCollection( 'library', this)
    @graveyard = new CardCollection( 'graveyard', this)
    @battlefield = new Battlefield( 'battlefield', this)
    @hand = new Hand( 'hand',  this)

  settings: => @get('settings')
  browsables: => @get('browsables')
  spectator: => @get('spectator')
  connected: => @get('connected')
  lives: => @get('lives')
  color: => @get('color')
  name: => @get('name')
  id: => @get('_id')

  # true if the battlefield should be rotated by default
  show_rotated_battlefield: (player) =>
    if @spectator()
      # bullshit - that's never called because
      false
    else
      player.id != @id

  can_browse: (collection) =>
    @spectator() ||
    collection.public() ||
    collection.player.local ||
    _.include( collection.player.browsables(), collection.id)


class UserCollection extends Backbone.Collection
  model : Player

Player.all = new UserCollection()


window.User = Player # Legacy
window.Player = Player
window.UserCollection = UserCollection