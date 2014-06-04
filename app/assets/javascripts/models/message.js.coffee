# -*- mode: css; tab-width: 2; -*-
# for more details see: http://emberjs.com/guides/models/defining-models/

Mana.Message = DS.Model.extend
  author: DS.attr 'string'
  text: DS.attr 'string'


Mana.Message.FIXTURES = [
  {
    id: 1
    author: null
    text: "Player Kolohnat joined the game."
  }
  {
    id: 2
    author: "Kolohnat"
    text: "let's play"
  }
  {
    id: 3
    author: "Smrada"
    text: "wait"
  }
  {
    id: 4
    author: "Kolohnat"
    text: "ok"
  }
]
