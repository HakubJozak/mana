# set Moustache style templates for Underscore
_.templateSettings = {
  interpolate : /\{\{(.+?)\}\}/g
}

# TODO - Every card is bound with one CardView - test this!
class Card extends Backbone.Model

  defaults:
    # TODO: put loading image here
    # image: 'http://example.com/unknown.jpg'
    # position: 'grid-0-0'
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
  image: => @get('image_url')
  url: => @get('url')
  name: => @get('name')
  counters: => @get('counters')
  power: => @get('power')
  toughness: => @get('toughness')

  initialize: =>
    throw 'Missing card ID' unless @id
    throw 'Missing user_id' unless @get('user_id')
    throw 'Missing order' if @get('order') == null

    # throw 'Missing container' unless @container
    # CardCollection.all.add(this)
    # throw 'Missing card owner' unless @owner
    # LEGACY
    @element = @el
    Card.all[@id] = this

  hidden: =>
     false

  adjust: (property, delta) =>
    value = (@get(property) || 0) + delta

    # FIXME: really ugly way to create hash with given key
    attrs = {}
    attrs[property] = value

    card = if @covered() then 'card' else @name()
    Message.action "changed #{property} of '#{card}' to #{value}."

    @set(attrs)
    @save()
    value

  toJSON: =>
    @attributes['collection_id'] = @collection.id if @collection
    super()

  load: (data) =>
    opts = { silent: true }
    @set(data, opts)
    @change()

  put_to_bottom: =>
    User.local.library.put_to_bottom(this)
    false

  put_to_hand: =>
    User.local.hand.add_on_top(this)
    false

  put_on_battlefield: =>
    CardCollection.all['battlefield'].put(this)
    false

  toggle_covered: (state = null, opts = {}) =>
    state ||= !@get('covered')
    @set({ covered : state })
    @save()
    false

  toggle_tapped: (state = null, opts = {}) =>
    state ||= !@get('tapped')
    @set({ tapped : state })
    @save()
    false

  transform: =>
    if @get('backside')?
      b = @get('backside')
      @set(backside: { name: @get('name'), image_url: @get('image_url'), url: @get('url') })
      @set(name: b.name, url: b.url, image_url: b.image_url)
      @save()
    false

  change_position: (pos) =>
    @set({ position: pos })
    @save()
    this

Card.all = {}
window.Card = Card
