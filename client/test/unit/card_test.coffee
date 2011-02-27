module 'Card tests'
  setup: ->
    @card = new Card({ id: 42, name: 'Forest', image: 'http://a.jpg'})

test 'Attributes are assigned in constructor', ->
  equals @card.name(), 'Forest'
  equals @card.image(), 'http://a.jpg'

test 'is not tapped by default', ->
  equals @card.tapped(), false

test 'throws exception on null ID', ->
  raises ->
    new Card()

test 'has non-null ID', ->
  ok _.isNumber(@card.id)

test 'can be tapped', ->
  @card.toggle_tapped().tapped()


module 'CardView dsfds'
  setup: ->
    @card = new Card({ name: 'Forest', image: 'http://a.jpg', id: 42 })
    @view = new CardView({ model: @card })

test 'creates correct element', ->
  equals $(@view.el).find('img').attr('src'), 'http://a.jpg'
  equals $(@view.el).attr('id'), 'card-42'
  ok $(@view.el).hasClass('card')

test 'tapping a card changes its view', ->
  @card.toggle_tapped(true)
  ok $(@view.el).hasClass('tapped')

test 'covering should show back side of the card', ->
  @card.toggle_covered(false)
  @card.toggle_covered(true)
  equals $(@view.el).find('img').attr('src'), '/images/back.jpg'

