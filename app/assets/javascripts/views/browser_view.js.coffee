Mana.BrowserView = Ember.View.extend
  templateName: 'browser'
  tagName: 'div'
  classNames: [ 'browser' ]


Mana.BrowserView.CardView = Ember.View.extend Mana.Draggable, {
  tagName: 'div'
  classNames: [ 'slot browser-card' ]

  create: ->
    @set 'stack', '.slot'
    @set 'revert','invalid'

  start: ->
    console.info @get('content.frontside')

  stop: ->
    console.info @get('content.frontside')
}
      # position: 0
      # scope: 'cards'
      # snap: '.card'
      # snapMode: 'inner'
      # scroll: false
      # revert: 'invalid'
      # stop: prevent_detail
      # containment: 'window'
      # zIndex: 99999
