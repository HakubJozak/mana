# For more information see: http://emberjs.com/guides/routing/

Mana.Router.map ()->
  @resource 'help'
  @resource 'cards', ->
    @resource('card', path: '/:card_id')


Mana.CardsRoute = Ember.Route.extend(
  model: (params) ->
    Mana.Card.FIXTURES
  actions:
    tap: ->
      @set 'tapped', !@get('tapped')
      false
)

Mana.CardRoute = Ember.Route.extend(
  model: (params) ->
    Mana.Card.FIXTURES.findBy 'id',params.card_id
)
