# -*- tab-width: 2; -*-
# for more details see: http://emberjs.com/guides/models/defining-models/

Mana.Game = DS.Model.extend
  name: DS.attr 'string'
  createdAt: DS.attr 'date'

  cards: DS.hasMany('card')
  players: DS.hasMany('player')
#  exile: DS.hasMany('card')

  first_player: (->
    @get('players.firstObject')
    ).property()

  current_player: (->
    p = @get('players').findBy('current', true)
    ).property('players')
