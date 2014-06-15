Mana.BrowserView = Ember.View.extend
  templateName: 'browser'
  tagName: 'div'
  classNames: [ 'browser' ]


Mana.BrowserView.CardView = Ember.View.extend Mana.Draggable, {
  tagName: 'div'
  classNames: [ 'slot browser-card card' ]

  didInsertElement: ->
    @_super()
    @setup_ui ({
      scope: 'cards'
      stack: '.card'
      scroll: false
      revert: 'invalid'
      zIndex: 1000
      snapMode: 'inner'
     })
    @$().data('card',@get('content'))

  start: ->


  stop: ->
    console.info @get('content.frontside')
}
