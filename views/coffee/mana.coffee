$(document).ready ->
  card = new Card
           name: 'Elvish Archdruid'
           image: 'http://magiccards.info/scans/en/m11/171.jpg'

  view = new CardView({ model: card }).render()
  $('#battlefield').append(view.el)


