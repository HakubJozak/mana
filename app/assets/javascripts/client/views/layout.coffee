class Layout extends Backbone.View

  constructor: (params) ->
    super(params)
    @model.bind('add', @add_player)

  add_player: (player) =>
    unless player.spectator()
      view = new UserView(model: player)

      if player.local
        HandView.bind_controls(player)
        $("#right-panel .users").append(view.el)
      else
        $("#left-panel .users").append(view.el)

      view.render()

window.Layout = Layout