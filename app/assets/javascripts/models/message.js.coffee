Mana.Message = DS.Model.extend
  text: DS.attr 'string'
  player: DS.belongsTo('player')
  game: DS.belongsTo('game')
