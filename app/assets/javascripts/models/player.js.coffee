# for more details see: http://emberjs.com/guides/models/defining-models/

Mana.Player = DS.Model.extend
  name: DS.attr 'string'
  current: DS.attr 'boolean'

  game: DS.belongsTo('game')
  deck: DS.belongsTo('slot')
  hand: DS.belongsTo('slot')
  graveyard: DS.belongsTo('slot')
  battlefield_slots: DS.hasMany('slot')
