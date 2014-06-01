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

table = []
for i in [1..10]
  console.info i
  table.pushObject Mana.Card.FIXTURES
console.info table
table


Mana.IndexController = Ember.ArrayController.extend(
  content: table
)

Mana.IndexRoute = Ember.Route.extend(
  id: 0
  setupController: ->
    window.slot = []
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
