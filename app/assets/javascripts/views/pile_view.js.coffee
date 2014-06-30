Mana.PileView = Ember.View.extend Mana.Draggable, {
  tagName: 'div'
  classNames: [ 'pile' ]
  templateName: 'pile'

  didInsertElement: ->
    @_super()
    @setup_ui ({
      scope: 'cards'
      stack: '.card'
      scroll: false
      revert: 'invalid'
      zIndex: 1000
      snapMode: 'inner'
      disabled: !@get('holder.top')
     })

    @$().data('card',@get('holder.top'))
    @$().data('container',@get('holder'))
}
