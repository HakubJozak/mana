Mana.BrowserView = Ember.View.extend
  templateName: 'browser'
  tagName: 'div'
  classNames: [ 'browser' ]


Mana.BrowserView.CardView = Ember.View.extend Mana.Draggable, {
  tagName: 'div'
  classNames: [ 'slot browser-card card' ]

  didInsertElement: ->
    @_super()

    settings = {
      scope: 'cards'
      stack: '.card'
      scroll: false
      revert: 'invalid'
      zIndex: 1000
      snapMode: 'inner'
     }

    for k,v of settings
      @get('ui').option(k,v)



  start: ->
    console.info 'started'

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
