# For more information see: http://emberjs.com/guides/routing/

Mana.Router.map ()->
  @resource 'help'
  @resource 'detail', path: '/cards/:card_id'



Mana.DetailRoute = Ember.Route.extend({
  model: (params) ->
    @store.find('card',params.card_id)

  actions:
    close: ->
      @get('controller').transitionToRoute("application")
      false

})
