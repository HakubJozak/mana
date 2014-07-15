Mana.Router.map ()->
  @resource 'help'
  @resource 'detail', path: '/cards/:card_id'
  @resource 'browser', path: '/browser/:slot_id', ->
    @resource 'cards_list'


Mana.CardsListController = Ember.ArrayController.extend({
  sortProperties: [ 'position' ]
  sortAscending: false

  needs: 'browser'
  all_visible: false
  visible_cards: []

  actions:
    show_all: ->
      @toggleProperty('all_visible')
      false


})

Mana.CardsListRoute = Ember.Route.extend({
  model: (params) ->
    @modelFor('browser').get('cards')

})




Mana.DetailRoute = Ember.Route.extend({
  model: (params) ->
    @store.find('card',params.card_id)

})
