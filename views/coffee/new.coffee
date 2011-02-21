# set Mustache style templates for Underscore
_.templateSettings = {
  interpolate : /\{\{(.+?)\}\}/g
}


class CardAttributes
  constructor: (@counter = 0, @power = 0, @toughness = 0) ->


class Card extends Backbone.Model

  @defaults =
    covered: true
    tapped: false
    attrs: new CardAttributes

  initialize: () ->


class CardView extends Backbone.View

  @tagName: 'div'
  @className: 'card'

  constructor: ->
    @template = _.template($('#card-template').html())
    super

  initialize: ->
    _.bindAll(this, "render")

  render: ->
     $(@el).html(@template(@model.toJSON()))
     $(@el).attr('id', "card-#{@model.id}")
     this