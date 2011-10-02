drag = (el, dx, dy) ->
  offsetBefore = el.position()
  $(el).simulate "drag", dx: dx || 0, dy: dy || 0
  offsetBefore

drag_to = (from, to, dx = 0, dy = 0) ->
  fromPosition = from.position()
  toPosition = to.position()

  dx = fromPosition.left - toPosition.left + dx
  dy = fromPosition.top - toPosition.top + dy

  diff = { dx: dx, dy: dy }

  $(from).simulate "drag", diff

  diff

module 'Drag & drop tests'
  setup: ->
    @card = $('.user .Library .card.ui-draggable:first')
    Backbone.sync = ->

test 'drops to hand', ->
  hand = $('.hand.ui-droppable')
  position = hand.position()

  # just make some scrolling before dragging
  jQuery('body').scrollTop(@card.height()/2)

  drag_to @card, hand, 20, 20
  equal @card.closest('.hand').attr('id'), hand.attr('id'), 'Should be in hand'

  drag @card, 10, 0
  equal @card.closest('.hand').attr('id'), hand.attr('id'), 'Should be in hand'
