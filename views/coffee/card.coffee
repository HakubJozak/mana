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
    @set({ covered: state })
    this

  toggle_tapped: (state = null) ->
    state ||= !@get('tapped')
    @set({ tapped: state })
    this

  tapped: ->
    @get('tapped')

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

  toggle_tapped: (e) ->
    @model.toggle_tapped()
    e.preventDefault()
    e.stopPropagation()

  initialize: ->
    _.bindAll(this, "render")

  render: ->
     attrs = @model.toJSON()
     attrs.image = unless @model.covered() then @model.image() else '/images/back.jpg'
     $(@el).html(@template(attrs))
     $(@el).attr('id', "card-#{@model.id}")
     if @model.tapped $(@el).addClass('tapped') else $(@el).removeClass('tapped')
     $(@el).addClass('card')
     @init_dragged()
     this

  init_dragged: ->
    console.info @el
    $(@el).draggable {
      scope: 'cards',
      snap: '.card',
      #start: toggleDragged(),
      #stop: toggleDragged(),
      scroll: true,
      revert: 'invalid',
      containment: '#desk',
      snapMode: 'inner',
      # TODO: simulate this - removed because of z-index mess
      # stack: '.card',
      zIndex: 9999
    }


class CardCollection extends Backbone.Collection
  model : Card

  constructor: ->
    super
#    @refresh($FOURSQUARE_JSON)
