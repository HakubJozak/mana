# for more details see: http://emberjs.com/guides/models/defining-models/

Mana.Card = DS.Model.extend
  name: DS.attr 'string'
  frontside: DS.attr 'string'
  backside: DS.attr 'string'

  power: DS.attr 'number'
  toughness: DS.attr 'number'
  counters: DS.attr 'number'

  covered: DS.attr 'boolean'
  tapped: DS.attr 'boolean'
  flipped: DS.attr 'boolean'

  power_and_toughness: (->
    [ p,t ] = [ @get('power'), @get('toughness') ]
    "#{p || '-'}/#{t || '-'}" if p or t
  ).property('power','toughness')

  flip: ->
    if @get('backside')
      @set('flipped', !@get('flipped'))

  tap: ->
    @set('tapped', !@get('tapped'))

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
