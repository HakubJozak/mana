Mana.PopupView = Ember.View.extend
  layoutName: 'popup'

  click: ->
    @get('controller').transitionToRoute('application')
    false
