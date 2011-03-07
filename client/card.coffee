# set Moustache style templates for Underscore
_.templateSettings = {
  interpolate : /\{\{(.+?)\}\}/g
}

class Card extends Backbone.Model

  defaults:
    # TODO: put loading image here
    # image: 'http://example.com/unknown.jpg'
    position: { x: 0, y: 0 }
    covered: true
    tapped: false
    overlay:
      show: false
      counters: 0
      power: 0
      toughness: 0

  initialize: ->
    throw 'Missing card ID' unless @id
    # throw 'Missing container' unless @container
    # CardCollection.all.add(this)
    # throw 'Missing card owner' unless @owner
    # LEGACY
    @element = @el
    @set({ image: @get('image_url')}) unless @get('image')

  toggle_covered: (state = null) ->
    @switch 'covered', state

  toggle_tapped: (state = null) ->
    @switch 'tapped', state

  change_position: (pos) ->
    @set({ position: pos })
    @save()

  switch: (attr, state) ->
    state ||= !@get(attr)
    @set({ "#{attr}" : state })
    @save()
    this

  tapped: -> @get('tapped')
  covered: -> @get('covered')
  image: -> @get('image')
  name: -> @get('name')



class CardCollection extends Backbone.Collection
  model : Card

  constructor: (@name, params) ->
    super(params)
    throw 'Name of the CardCollection missing' unless @name
#    @refresh($FOURSQUARE_JSON)
