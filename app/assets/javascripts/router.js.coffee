Mana.Router.map ()->
  @resource 'help'
  @resource 'detail', path: '/cards/:card_id'
  @resource 'browser', path: '/browser/:slot_id'


Mana.DetailRoute = Ember.Route.extend({
  model: (params) ->
    @store.find('card',params.card_id)

})

Mana.BrowserRoute = Ember.Route.extend({
  model: (params) ->
    @store.find('slot',params.slot_id)
})
