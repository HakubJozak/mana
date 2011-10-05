class Game extends Backbone.Model

  initialize: ->

  message:  (msg) =>
    InfoView.instance.render(msg)

  create_card: (image_url) =>
    id = User.local().create_unique_id()
    card = new Card({ id: id,  image_url: image_url })
    view = new CardView({ model: card })
    $('#battlefield').ob().dropped(view)


window.Game = Game