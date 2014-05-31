# For more information see: http://emberjs.com/guides/routing/

Mana.Router.map ()->
  @resource 'help'
  @resource 'cards'
#    @resource('card', path: '/:card_id')


Mana.CardsRoute = Ember.Route.extend(
  actions:
    add_stuff: ->
      debugger
      window.slot.addObject  @store.find('card',1)
      false

  model: (params) ->
    'there is no such thing as model'
)

Mana.CardRoute = Ember.Route.extend(
  model: (params) ->
    @store.find('card',params.card_id)
)
