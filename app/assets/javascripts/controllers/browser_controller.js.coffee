Mana.BrowserController = Ember.ObjectController.extend({
  # visible_cards: Ember.OrderedSet.create()

  # visible: (-> @get('visible_cards').toArray() ).property('visible_cards.@each')

  # invisible: (->
  #   arr = @get('cards').reject (card) =>
  #     @get('visible_cards').has(card)
  #   arr.toArray()
  # ).property('cards.@each','visible_cards.@each')
  all_visible: false


  actions:
    shuffle: ->
      console.debug "Shuffling #{slot.get('name')}"
      slot.shuffle()
      false

    show_next: ->
      false

    show_all: ->
      console.info 'prdel'
      @toggleProperty('all_visible')
      false
})
