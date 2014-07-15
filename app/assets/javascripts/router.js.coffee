Mana.Router.map ()->
  @resource 'help'
  @resource 'detail', path: '/cards/:card_id'
  @resource 'browser', path: '/browser/:slot_id', ->
    @resource 'cards_list'


Mana.CardsListController = Ember.ArrayController.extend({
  needs: 'browser'
  all_visible: true
})

Mana.CardsListRoute = Ember.Route.extend({
  model: (params) ->
    @modelFor('browser').get('cards')

})




Mana.DetailRoute = Ember.Route.extend({
  model: (params) ->
    @store.find('card',params.card_id)

})
