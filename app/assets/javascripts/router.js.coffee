# For more information see: http://emberjs.com/guides/routing/

Mana.Router.map ()->
  @resource('help')
  @resource('card', path: '/card/:card_id')
  @resource 'stamps', ->
    @resource('stamp', path: ':stamp_id')

Mana.StampsRoute = Ember.Route.extend(
  model: ->
    Mana.Stamp.FIXTURES

)

Mana.StampRoute = Ember.Route.extend(
  model: (params) ->
   {
     id: '1'
     name: "Forest"
     frontside: "http://mtgimage.com/multiverseid/289.jpg"
     backside: null
   }
#    Mana.Stamp.FIXTURES.findBy 'id',params.stamp_id

)
