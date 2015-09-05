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

  all_but_current_players: (->
    @get('players').rejectBy('id', Mana.current_player_id)
   ).property('players.@each')

  current_player: (->
    @get('players').findBy('id', Mana.current_player_id)
   ).property()
