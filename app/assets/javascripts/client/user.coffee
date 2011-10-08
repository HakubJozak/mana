class User extends Backbone.Model

  constructor: (params) ->
    super(params)

    # set the local flag and clean it
    if params.local
      User.local = this
      @unset('local',{ silent: true })
      @local = true

    alert('hewlrewlr')
    @set({ lives: 20 })
    # TODO: DRY
    @library = new CardCollection("library-#{@id}", 'library')
    @graveyard = new CardCollection("graveyard-#{@id}", 'graveyard')
    @exile = new CardCollection("exile-#{@id}", 'exile')
    @hand = new Hand({ user: this })

  lives: => @get('lives')
  color: => @get('color')
  name: => @get('name')
  id: => @get('_id')

class UserCollection extends Backbone.Collection
  model : User

User.all = new UserCollection()

window.User = User
window.UserCollection = UserCollection