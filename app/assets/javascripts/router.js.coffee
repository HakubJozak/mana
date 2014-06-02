# For more information see: http://emberjs.com/guides/routing/

Mana.Router.map ()->
  @resource 'help'

Mana.SlotView = Ember.CollectionView.extend({
  tagName: 'ul'
  classNames: [ 'slot' ]
  itemViewClass: Mana.CardView
  emptyView: Ember.View.extend({
    template: Ember.Handlebars.compile("<img src='/assets/empty.png'>")
   })
})



Mana.IndexController = Ember.ArrayController.extend(
)

Mana.IndexRoute = Ember.Route.extend(
  id: 0
  setupController: (controller,_model_) ->
    table = []
    for i in [1..10]
      console.info i
      table.pushObject @store.find('card')
    controller.set('model',table)


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
