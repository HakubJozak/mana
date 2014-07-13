# -*- tab-width: 2; -*-

Mana.Game = DS.Model.extend
  name: DS.attr 'string'
  createdAt: DS.attr 'date'

  cards: DS.hasMany('card')
  players: DS.hasMany('player')
  slots: DS.hasMany('slot')
  messages: DS.hasMany('message')

  first_player: (->
    @get('players.firstObject')
    ).property()

  current_player: (->
    @get('players').findBy('id', Mana.current_player_id)
   ).property()
