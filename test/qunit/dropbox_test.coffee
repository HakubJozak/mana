card_attrs = { name: 'Forest', image: 'http://a.jpg', id: 42, user_id: 43, order: 1 }
user_params = { id: 42, color: '#ff0000', name: 'Fake', cards: [ card_attrs ] }

module 'Dropbox'
  setup: ->
    @card = new Card(card_attrs)
    @user = new User(user_params)

    -# @graveyard = new CardCollection("graveyard",'Graveyard')
    -# @hand = new Hand({ user: @user })

    -# @dropbox = new Dropbox({ model: @graveyard })
    -# @hand_view = new HandView({ model: @hand });
    Backbone.sync = ->
