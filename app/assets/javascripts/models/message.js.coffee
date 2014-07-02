Mana.Message = DS.Model.extend
  player: DS.belongsTo('player')
  text: DS.attr 'string'
