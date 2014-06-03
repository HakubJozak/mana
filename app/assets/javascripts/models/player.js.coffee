# for more details see: http://emberjs.com/guides/models/defining-models/

Mana.Player = DS.Model.extend
  name: DS.attr 'string'

  hand: DS.hasMany('card')
  deck: DS.hasMany('card')
  graveyard: DS.hasMany('card')
  battlefield: DS.hasMany('card')
