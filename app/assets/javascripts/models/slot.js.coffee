Mana.Slot = DS.Model.extend
  name: DS.attr 'string'

  player: DS.belongsTo('player')
  game: DS.belongsTo('game')
  cards: DS.hasMany('card')

  length: ( ->
    @get('cards.length')
  ).property('cards.@each')

  empty: ( ->
    @get('cards.length') == 0
  ).property('cards.@each')

  top: ( ->
    @get('cards.lastObject')
  ).property('cards.@each')

  bottom: ( ->
    @get('cards.firstObject')
  ).property('cards.@each')

  next_position: ->
    if last = @get('cards.lastObject')
      last.get('position') + 1
    else
      0
