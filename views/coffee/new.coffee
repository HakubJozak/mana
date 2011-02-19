class CardAttributes
  constructor: (@counter = 0, @power = 0, @toughness = 0) ->


class BCard extends Backbone.Model

  @defaults =
    covered: true
    tapped: false
    attrs: new CardAttributes

  initialize: ->

class CardView extends Backbone.View

  @tagName: 'div'
  @className: 'card'

  initialize: ->
    _.bindAll(this, "render")
    @id = "card-#{@options.model.id}"

  render: ->


card = new BCard({ covered: false })


new CardView({ model: card })