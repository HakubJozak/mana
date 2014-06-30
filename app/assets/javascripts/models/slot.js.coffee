Mana.Slot = DS.Model.extend
  name: DS.attr 'string'

  player: DS.belongsTo('player')
  game: DS.belongsTo('game')
  cards: DS.hasMany('card')

  length: ( ->
    @get('cards.length')
  ).property('cards')

  top: ( ->
    @get('cards.lastObject')
  ).property('cards')

  below_top: ( ->
    if (l = @get('cards.length')) > 1
      @get('cards').objectAt(l - 2)
    else
      undefined
  ).property('cards')

  bottom: ( ->
    @get('cards.firstObject')
  ).property('length')

  next_position: ->
    if last = @get('cards.lastObject')
      last.get('position') + 1
    else
      0
