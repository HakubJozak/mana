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

test 'User init', ->
  equals @user.name(), 'Fake'
  equals @user.library.length, 1

test 'Card drop', ->
  view = new UserView({ model: @user })
  card = @user.library.first()
  equals card.name(), 'Forest'

  cview = CardView.find_or_create(card)
  hand_view = view.components['hand']

  equals cview.el.parent().attr('id'), 'desk'
  hand_view._dropped_and_turned({}, { draggable: cview.el })
  equals cview.el.parent().attr('id'), 'hand'

