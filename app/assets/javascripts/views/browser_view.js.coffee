# for more details see: http://emberjs.com/guides/views/

Mana.BrowserView = Ember.View.extend Mana.Draggable, {
  templateName: 'browser'
  tagName: 'div'
  classNames: [ 'browser' ]
  }
