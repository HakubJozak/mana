# for more details see: http://emberjs.com/guides/models/defining-models/

Mana.Game = DS.Model.extend
  name: DS.attr 'string'
  createdAt: DS.attr 'date'

  players: DS.hasMany('player')
  exile: DS.hasMany('card')
