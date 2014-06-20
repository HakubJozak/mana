# for more details see: http://emberjs.com/guides/models/defining-models/

Mana.Player = DS.Model.extend
  name: DS.attr 'string'
  current: DS.attr 'boolean'

  game: DS.belongsTo('game ')
  deck: DS.hasMany('card')
  hand: DS.hasMany('card')
  graveyard: DS.hasMany('card')
  battlefield: DS.hasMany('card')

  slots: (->
    field = @get('battlefield')
    result = []

    for i in [0..15]
      slot = field.filter (card, index, self) ->
               true if card.get('position') == i
      result.pushObject(slot)

    result
   ).property('battlefield')
