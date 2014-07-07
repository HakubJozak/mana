Mana.DetailView = Mana.PopupView.extend
  templateName: 'detail'

  click: ->
    @get('controller').transitionToRoute('application')
    false
