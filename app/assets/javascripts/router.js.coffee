# For more information see: http://emberjs.com/guides/routing/

Mana.Router.map ()->
  @resource 'help'

Mana.SlotView = Ember.CollectionView.extend({
  tagName: 'ul'
  itemViewClass: Mana.CardView
})

Mana.IndexRoute = Ember.Route.extend(
  id: 0
  setupController: ->
    window.slot = []
    window.view = Mana.SlotView.create
      content: window.slot
    window.view.appendTo('#slotty')

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
