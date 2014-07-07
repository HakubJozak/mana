Mana.DetailView = Ember.View.extend
  templateName: 'detail'
  layoutName: 'popup'

  click: ->
    @get('controller').transitionToRoute('application')
    false
