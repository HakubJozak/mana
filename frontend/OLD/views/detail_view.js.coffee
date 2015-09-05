Mana.DetailView = Mana.PopupView.extend
  templateName: 'detail'
  contentClass: 'detail'

  click: ->
    @get('controller').transitionToRoute('application')
    false
