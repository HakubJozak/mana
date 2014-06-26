Mana.Slot = DS.Model.extend
  player: DS.belongsTo('player')
  game: DS.belongsTo('game')
  cards: DS.hasMany('card')

  length: ( ->
    @get('cards.length')
  ).property('cards.@each')

  next_position: ->
    if last = @get('cards.lastObject')
      last.get('position') + 1
    else
      0
