# set Moustache style templates for Underscore
_.templateSettings = {
  interpolate : /\{\{(.+?)\}\}/g
}

class Card extends Backbone.Model

  defaults:
    # TODO: put loading image here
    image: 'http://example.com/unknown.jpg'
    covered: false
    tapped: false
    counters: 0
    power: 0
    toughness: 0

  toggle_covered: (state = null) ->
    state ||= !@get('covered')
    @set({ tapped: state })
    this

  toggle_tapped: (state = null) ->
    state ||= !@get('tapped')
    @set({ tapped: state })
    this

  tapped: -> @get('tapped')

  covered: -> @get('covered')

  image: -> @get('image')

  name: -> @get('name')

class CardView extends Backbone.View

  @BACK_SIDE: "/images/back.jpg"
  @tagName: 'div'
  @className: 'card'

  events:
    click : "toggle_tapped"

  constructor: ->
    super
    @template = _.template($('#card-template').html())
    @model.bind 'change', @render

  toggle_tapped: ->
    @model.toggle_tapped()

  initialize: ->
    _.bindAll(this, "render")

  render: ->
     attrs = @model.toJSON()
     attrs.image = unless @model.covered() then @model.image() else '/images/back.jpg'
     $(@el).html(@template(attrs))
     $(@el).attr('id', "card-#{@model.id}")
     $(@el).addClass('tapped') if @model.tapped()
     $(@el).addClass('card')
     this



class CardCollection extends Backbone.Collection
  model : Card

  constructor: ->
    super
#    @refresh($FOURSQUARE_JSON)
