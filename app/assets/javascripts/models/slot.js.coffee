Mana.Slot = DS.Model.extend
  name: DS.attr 'string'

  player: DS.belongsTo('player')
  game: DS.belongsTo('game')
  cards: DS.hasMany('card')

  length: ( ->
    @get('cards.length')
  ).property('cards.@each')

  top: ( ->
    @get('cards.lastObject')
  ).property('cards.@each')

  below_top: ( ->
    if (l = @get('cards.length')) > 1
      @get('cards').objectAt(l - 2)
    else
      undefined
  ).property('cards.@each')

  bottom: ( ->
    @get('cards.firstObject')
  ).property('length')

  next_position: ->
    if last = @get('cards.lastObject')
      last.get('position') + 1
    else
      0

  after_drop: (card) ->
    switch @get('name')
      when 'hand'
        card.set('covered',false)
        card.set('tapped',false)
      when 'library'
        card.set('covered',true)
      else
        card.set('covered',false)

  shuffle: ->
    cards = @get('cards')
    arr = cards.toArray()
    i = arr.length

    while --i
      j = Math.floor(Math.random() * (i+1))
      card = cards.objectAt(j)
      cards.removeObject(card)

      cards.pushObject(card)

  #  https://gist.github.com/ddgromit/859699
  shuffle2: ->
    cards = @get('cards')
    arr = cards.toArray()
    i = arr.length

    if i is 0 then return false

    while --i
      j = Math.floor(Math.random() * (i+1))
      arr[i].set('position',j)
      arr[j].set('position',i)
      [arr[i], arr[j]] = [arr[j], arr[i]] # use pattern matching to swap

    # LAME so much, it couldn't possibly get lamer
    @removeObject(c) for c in cards
    @pushObject(c) for c in cards
    @save()
