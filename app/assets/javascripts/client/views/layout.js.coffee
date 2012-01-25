class Layout extends Backbone.View

  constructor: (params) ->
    super(params)
    @model.bind('add', @add_player)
    @model.bind('remove', @add_player)

  add_player: (player) =>
    unless player.spectator()
      player_view = new UserView(model: player)
      battlefield_view = new BattlefieldView( model: player.battlefield, player: player );

      if player.local
        HandView.bind_controls(player)
        $("#right-panel .users").append(player_view.el)
      else
        $("#left-panel .users").append(player_view.el)

      battlefield_view.render()

window.Layout = Layout