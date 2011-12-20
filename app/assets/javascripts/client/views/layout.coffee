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

        part = BattlefieldView.instance.create_user_part(player, 8, 2)
        $('#battlefield .local').append(part)
      else
        $("#left-panel .users").append(view.el)

        part = BattlefieldView.instance.create_user_part(player, 12, 3)
        $('#battlefield .remote').append(part)


      view.render()

window.Layout = Layout