# for more details see: http://emberjs.com/guides/models/defining-models/

Mana.Player = DS.Model.extend
  name: DS.attr 'string'
  current: DS.attr 'boolean'

  deck: DS.hasMany('card')
  hand: DS.hasMany('card')
  graveyard: DS.hasMany('card')
  battlefield: DS.hasMany('card')
