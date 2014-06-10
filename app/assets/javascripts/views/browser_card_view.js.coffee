Mana.BrowserCardView = Ember.View.extend Mana.Draggable, {
  templateName: 'browser_card'
  tagName: 'div'
  classNames: [ 'slot browser-card' ]

  start: ->
    console.info 'start'

  stop: ->
    console.info @get('content.frontside')
  # didInsertElement: ->
  #   @_super()
  #   @$('.slot').draggable

    # part.find('td').droppable
    #   scope: 'cards'
    #   hoverClass: 'card-over'
    #   drop: @dropped
    #   accept: (draggable) ->
    #     if ($('.hand.card-over').length < 1) && draggable.hasClass('card')
    #       return true
    #     else
    #       $('td.card-over').removeClass('card-over')
    #       return false

}
