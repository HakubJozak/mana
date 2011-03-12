# set Moustache style templates for Underscore
_.templateSettings = {
  interpolate : /\{\{(.+?)\}\}/g
}

# TODO - Every card is bound with one CardView - test this!
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

  hidden: =>
     false
#    @collection.visible?

  toJSON: =>
    @attributes['collection_id'] = @collection.id
    super()

  set: (data) =>
    @move_to CardCollection.all[data.collection_id] if data.collection_id
    super(data)

  # Move from one collection to some other.
  #
  move_to: (target) =>
    return if target == @collection
    @collection.remove(this)
    target.add(this)

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

  @all: []

  constructor: (@id, @name, params) ->
    super(params)
    CardCollection.all[@id] = this
    throw 'Name of the CardCollection missing' unless @name
    throw 'Name of the CardCollection missing' unless @id
    @trigger('add')

  visible: -> false