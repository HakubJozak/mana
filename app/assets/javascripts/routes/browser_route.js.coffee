Mana.BrowserRoute = Ember.Route.extend({
  model: (params) ->
    @store.find('slot',params.slot_id)
})
