Mana.Card = DS.Model.extend
  location: DS.attr 'string'
  position: DS.attr 'number'
  order: DS.attr 'number'

  name: DS.attr 'string'
  frontside: DS.attr 'string'
  backside: DS.attr 'string'

  power: DS.attr 'number'
  toughness: DS.attr 'number'
  counters: DS.attr 'number'

  covered: DS.attr 'boolean'
  tapped: DS.attr 'boolean'
  flipped: DS.attr 'boolean'

  # player: DS.belongsTo('player')
  # game: DS.belongsTo('game')

  power_and_toughness: (->
    [ p,t ] = [ @get('power'), @get('toughness') ]
    "#{p || '-'}/#{t || '-'}" if p or t
  ).property('power','toughness')

  flip: ->
    if @get('backside')
      @set('flipped', !@get('flipped'))

  tap: ->
    @set('tapped', !@get('tapped'))

  move_to: (location,position = 0) ->
    @set('location',location)
    @set('position',position)

  toggleCovered: ->
    @set('covered', !@get('covered'))


Mana.Card.FIXTURES = [
  {
    id: 1
    power: 1
    toughness: 3
    counters: 1
    tapped: false,
    name: "Forest"
    frontside: "http://mtgimage.com/multiverseid/289.jpg"
    backside: null
  }
  {
    id: 2
    power: 10
    tapped: true,
    name: "Child of the Night"
    frontside: "http://mtgimage.com/multiverseid/221212.jpg"
    backside: "http://mtgimage.com/multiverseid/221222.jpg"
  }
  {
    id: 3
    tapped: true,
    covered: true,
    name: "Mountain"
    frontside: "http://mtgimage.com/multiverseid/221212.jpg"
    backside: "http://mtgimage.com/multiverseid/221222.jpg"
  }

]
