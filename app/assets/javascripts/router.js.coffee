# For more information see: http://emberjs.com/guides/routing/

Mana.Router.map ()->
  @resource 'help'
  @resource 'cards', ->
    @resource('card', path: '/:card_id')


Mana.CardsRoute = Ember.Route.extend(
  model: (params) ->
    @store.find('card')

)

Mana.CardRoute = Ember.Route.extend(
  model: (params) ->
    @store.find('card',params.card_id)
)
