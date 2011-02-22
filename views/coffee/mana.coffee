$(document).ready ->
  card = new Card
           name: 'Elvish Archdruid'
           image: '/images/cards/1.jpg'

  view = new CardView({ model: card }).render()
  $('#battlefield').append(view.el)


