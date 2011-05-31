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

  order: => @get('order')
  position: => @get('position')
  tapped: => @get('tapped')
  covered: => @get('covered')
  image: => @get('image')
  name: => @get('name')
  counters: => @get('counters')
  power: => @get('power')
  toughness: => @get('toughness')

  initialize: ->
    throw 'Missing card ID' unless @id
    throw 'Missing user_id' unless @get('user_id')
    throw 'Missing order' if @get('order') == null

    # throw 'Missing container' unless @container
    # CardCollection.all.add(this)
    # throw 'Missing card owner' unless @owner
    # LEGACY
    @element = @el
    @set({ image: @get('image_url')}) unless @get('image')

  shuffle: =>
    sortBy ->  Math.random() > 0.5
    # HACK: does not work remotely
    @render()


  hidden: =>
     false

  toJSON: =>
    @attributes['collection_id'] = @collection.id if @collection
    super()

  load: (data) =>
    opts = { silent: true }
    @set(data, opts)
    @move_to(CardCollection.all[data.collection_id],opts) if data.collection_id
    @change()

  set: (data, opts = {}) =>
    super(data, opts)
    @move_to(CardCollection.all[data.collection_id],opts) if data.collection_id

  # Move from one collection to some other, optionally adjusting the position.
  #
  move_to: (target, options = {}) =>
    return if target == @collection
    @collection.remove(this, options)

    unless target.last()? || target.first()?
      @set order: 0
    else
      order = switch options['order']
        when 'last' then target.last().order() + 10
        when 'first' then target.first().order() - 10
      
      @set { order: order }
      
    target.add(this, options)

  toggle_covered: (state = null, opts = {}) =>
    @_switch 'covered', state, opts

  toggle_tapped: (state = null, opts = {}) =>
    @_switch 'tapped', state, opts

  change_position: (pos, opts = { save: true }) ->
    @set({ position: pos })
    @save() if opts.save

  adjust: (attr, delta) ->
    value = (@get(attr) || 0) + delta
    @set({ "#{attr}": value })
    @save()

  _switch: (attr, state) =>
    state ||= !@get(attr)
    @set({ "#{attr}" : state })
    @save()
    this
