# set Mustache style templates for Underscore
_.templateSettings = {
  interpolate : /\{\{(.+?)\}\}/g
}


class CardAttributes
  constructor: (@counter = 0, @power = 0, @toughness = 0) ->


class Card extends Backbone.Model

  defaults:
    covered: true
    tapped: false
    attrs: new CardAttributes

  tapped: ->
    @get('tapped')

  toggle_tapped: ->
    @set({ tapped: !@get('tapped') })
    this

class CardView extends Backbone.View

  @tagName: 'div'
  @className: 'card'

  constructor: ->
    super
    @template = _.template($('#card-template').html())
    @model.bind 'change', @render

  initialize: ->
    _.bindAll(this, "render")

  render: ->
     attrs = @model.toJSON()
     attrs.css_class = 'card tapped'
     $(@el).html(@template(attrs))
     $(@el).attr('id', "card-#{@model.id}")
     $(@el).addClass('tapped') if @model.tapped()
     this



class CardCollection extends Backbone.Collection
  model : Card

  constructor: ->
    super
#    @refresh($FOURSQUARE_JSON)
