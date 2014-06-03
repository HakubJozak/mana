# For more information see: http://emberjs.com/guides/routing/

Mana.Router.map ()->
  @resource 'help'


Mana.IndexController = Ember.ArrayController.extend(
)

Mana.IndexRoute = Ember.Route.extend(
  id: 0
  setupController: (controller,_model_) ->
    # prepare empty battlefield
    # battlefield = []
    # battlefield = for i in [0..15]
    #   game.pushObject []
    # for card in @store.find('card')
    #   battlefield[card.get('position')]

    game = @store.find('game',9)
    game.then (g) ->
      console.info g.get('players').get('length')
      g.get('players').forEach (p) ->
        console.info p.get('name')
        console.info p.get('deck').get('length')
        p.get('deck').forEach (c) ->
          console.info c.get('name')

    controller.set('model', [])

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
