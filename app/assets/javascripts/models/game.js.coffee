# -*- tab-width: 2; -*-

Mana.Game = DS.Model.extend
  name: DS.attr 'string'
  createdAt: DS.attr 'date'

  cards: DS.hasMany('card')
  players: DS.hasMany('player')
  slots: DS.hasMany('slot')

  first_player: (->
    @get('players.firstObject')
    ).property()

  current_player: (->
    p = @get('players').findBy('current', true)
    ).property('players')
