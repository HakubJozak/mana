class CardViewDropbox extends CardView

  constructor: (params, @dropbox) ->
    super(params)

  render: =>
    super()
    @el.css('position','absolute')
    @el.offset({ top: @dropbox.box.offset().top + 5, left: @dropbox.box.offset().left + 5 })


window.CardViewDropbox = CardViewDropbox