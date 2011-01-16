class Library
  update: (cards) ->
    $(cards).each (i, params) ->
      card = new Card(params)
      card.turnOverLocally(true)
      card.element.css('position', 'absolute')
      $('#library').object().dropLocally(card)
