Mana.Card = DS.Model.extend
  position: DS.attr 'number'
  order: DS.attr 'number'
  slot_id: DS.attr 'number'

  name: DS.attr 'string'
  frontside: DS.attr 'string'
  backside: DS.attr 'string'

  power: DS.attr 'number'
  toughness: DS.attr 'number'
  counters: DS.attr 'number'

  covered: DS.attr 'boolean'
  tapped: DS.attr 'boolean'
  flipped: DS.attr 'boolean'

#  slot: DS.belongsTo('slot')
  # game: DS.belongsTo('game')

  power_and_toughness: (->
    [ p,t ] = [ @get('power'), @get('toughness') ]
    "#{p || '-'}/#{t || '-'}" if p or t
  ).property('power','toughness')

  flip: ->
    if @get('backside')
      @toggleProperty 'flipped'
      @save()

  tap: ->
    @toggleProperty 'tapped'
    @save()

  toggleCovered: ->
    @toggleProperty 'covered'
    @save()

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
