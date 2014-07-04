# for more details see: http://emberjs.com/guides/views/

Mana.PlusMinusView = Ember.View.extend
  templateName: 'plus_minus'
#  template: Ember.Handlebars.compile("<img src='#{image_path('empty.png')}'>")
  attributeBindings: ['tooltip'],
  classNames: [ "plus-minus" ]
  tooltip: 'Left click to raise, right click to lower.'



  click: (event) ->
    @incrementProperty('content', +1)
    event.preventDefault()

  contextMenu: (event) ->
    @incrementProperty('content', -1)
    event.preventDefault()
