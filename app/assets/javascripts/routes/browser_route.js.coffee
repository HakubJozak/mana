Mana.BrowserRoute = Ember.Route.extend({
  model: (params) ->
    @store.find('slot',params.slot_id)

  afterModel: (model,transition) ->
    console.info 'called'
    @transitionTo('cards_list')


})
