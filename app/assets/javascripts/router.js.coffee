# For more information see: http://emberjs.com/guides/routing/

Mana.Router.map ()->
  @resource 'help'


Mana.IndexController = Ember.ArrayController.extend(
)

Mana.IndexRoute = Ember.Route.extend(
  id: 0
  setupController: (controller,_model_) ->
    game = []
    for i in [1..3]
      game.pushObject @store.find('card')
    controller.set('model',game)

 # window.view = Mana.SlotView.create
 #   content: window.slot
 #    window.view.appendTo('#ember-app')

  actions:
    remove_stuff: ->
      @store.find('card',@id).then (value) ->
        window.slot.removeObject(value)
      @id -= 1;
      false

    add_stuff: ->
      @id += 1;
      @store.find('card',@id).then (value) ->
        window.slot.pushObject(value)
      false
)
