class Layout extends Backbone.View

  constructor: (params) ->
    super(params)
    @model.bind('add', @add_player)

  add_player: (player) =>
    unless player.spectator()
      view = new UserView(model: player)

      BattlefieldView.instance.create_user_part(player, 14, 3)

      if player.local
        HandView.bind_controls(player)
        $("#right-panel .users").append(view.el)
      else
        $("#left-panel .users").append(view.el)

      view.render()

window.Layout = Layout