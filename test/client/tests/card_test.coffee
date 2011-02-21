module 'Card'

test 'Attributes are assigned in constructor', ->
  card = new Card({ name: 'Forest', image_url: 'http://a.jpg'})
  equals card.get('name'), 'Forest'
  equals card.get('image_url'), 'http://a.jpg'


module 'CardView'

test 'creates correct element', ->
  card = new Card({ name: 'Forest', image_url: 'http://a.jpg', id: 42 })
  view = new CardView({ model: card }).render()
  equals $(view.el).find('img').attr('src'), 'http://a.jpg'
  equals $(view.el).attr('id'), 'card-42'
