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
    overlay: false
    counters: null
    power: null
    toughness: null

  position: -> @get('position')
  tapped: -> @get('tapped')
  covered: -> @get('covered')
  image: -> @get('image')
  name: -> @get('name')
  counters: => @get('counters')
  power: => @get('power')
  toughness: => @get('toughness')

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

  load: (data) =>
    opts = { silent: true }
    @set(data, opts)
    @move_to(CardCollection.all[data.collection_id],opts) if data.collection_id
    @change()

  set: (data, opts = {}) =>
    super(data, opts)
    @move_to(CardCollection.all[data.collection_id],opts) if data.collection_id

  # Move from one collection to some other.
  #
  move_to: (target, options = {}) =>
    return if target == @collection
    @collection.remove(this, options)
    target.add(this, options)

  toggle_covered: (state = null) ->
    @_switch 'covered', state

  toggle_tapped: (state = null) ->
    @_switch 'tapped', state

  change_position: (pos) ->
    @set({ position: pos })
    @save()

  adjust: (attr, delta) ->
    value = (@get(attr) || 0) + delta
    @set({ "#{attr}": value })
    @save()

  _switch: (attr, state) ->
    state ||= !@get(attr)
    @set({ "#{attr}" : state })
    @save()
    this



class CardCollection extends Backbone.Collection
  model : Card

  @all: []

  constructor: (@id, @name, params) ->
    super(params)
    CardCollection.all[@id] = this
    throw 'Name of the CardCollection missing' unless @name
    throw 'ID of the CardCollection missing' unless @id
    @trigger('add')

  visible: -> false