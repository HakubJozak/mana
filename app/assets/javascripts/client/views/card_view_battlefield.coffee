class CardViewBattlefield extends CardView

  render: =>
    super()
    @el.css('position','absolute')
    pos = @model.position()
    @el.css({ left: pos.x, top: pos.y })


window.CardViewBattlefield = CardViewBattlefield