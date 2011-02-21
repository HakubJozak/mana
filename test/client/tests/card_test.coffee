module 'Card'
  setup: ->
    @card = new Card({ name: 'Forest', image_url: 'http://a.jpg'})

test 'Attributes are assigned in constructor', ->
  equals @card.get('name'), 'Forest'
  equals @card.get('image_url'), 'http://a.jpg'

test 'is not tapped by default', ->
  equals @card.tapped(), false

test 'can be tapped', ->
  @card.toggle_tapped().tapped()


module 'CardView'
  setup: ->
    @card = new Card({ name: 'Forest', image_url: 'http://a.jpg', id: 42 })
    @view = new CardView({ model: @card }).render()

test 'creates correct element', ->
  equals $(@view.el).find('img').attr('src'), 'http://a.jpg'
  equals $(@view.el).attr('id'), 'card-42'

test 'tapping a card changes its view', ->
  @card.toggle_tapped()
  ok $(@view.el).hasClass('tapped')

