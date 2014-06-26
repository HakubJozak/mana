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
