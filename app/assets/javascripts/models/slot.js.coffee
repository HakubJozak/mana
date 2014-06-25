Mana.Slot = DS.Model.extend
  player: DS.belongsTo('player')
  game: DS.belongsTo('game')
  cards: DS.hasMany('card')

  size: ( ->
    @get('cards.length')
  ).property('cards.@each')
