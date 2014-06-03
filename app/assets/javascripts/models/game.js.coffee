# for more details see: http://emberjs.com/guides/models/defining-models/

Mana.Game = DS.Model.extend
  name: DS.attr 'string'
  createdAt: DS.attr 'date'

  cards: DS.hasMany('card')
  players: DS.hasMany('player')
#  exile: DS.hasMany('card')
