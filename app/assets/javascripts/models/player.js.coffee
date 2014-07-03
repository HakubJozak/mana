Mana.Player = DS.Model.extend
  current: DS.attr 'boolean'

  name: DS.attr 'string'
  lives: DS.attr 'number'
  poison_counters: DS.attr 'number'

  game: DS.belongsTo('game')
  deck: DS.belongsTo('slot')
  exile: DS.belongsTo('slot')
  hand: DS.belongsTo('slot')
  graveyard: DS.belongsTo('slot')

  battlefield_slots: DS.hasMany('slot')
  messages: DS.hasMany('message')

  adjust_lives: (delta) ->
    @incrementProperty('lives', delta)
    @save()
