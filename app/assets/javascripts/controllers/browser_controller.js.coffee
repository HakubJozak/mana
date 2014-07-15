Mana.BrowserController = Ember.ObjectController.extend({

  actions:
    shuffle: ->
      console.debug "Shuffling #{@get('name')}"
      @get('model').shuffle()
      false

})
