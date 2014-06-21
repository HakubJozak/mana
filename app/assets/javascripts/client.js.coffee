#= require jquery
#= require jquery.ui.draggable
#= require jquery.ui.droppable
#= require handlebars
#= require ember
#= require ember-data
#= require_self

#= require ./mixins/jquery_ui_base
#= require_tree ./mixins

#= require ./store
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./helpers
#= require_tree ./components
#= require_tree ./templates
#= require_tree ./routes
#= require ./router

# for more details see: http://emberjs.com/guides/application/



window.Mana = Ember.Application.create {
  rootElement: '#ember-app'
  ready: ->
    console.info 'Mana started.'
}

Mana.ApplicationAdapter = DS.ActiveModelAdapter
# Mana.ApplicationAdapter = DS.FixtureAdapter

# just for now
Mana.message_store = DS.Store.create({
#  revision: 12,
  adapter: DS.FixtureAdapter.create()
});

DS.ActiveModelAdapter.reopen({
#  namespace: 'games/9'
});


Mana.WebSocketHandler = Ember.Object.extend(
  uri: "ws://localhost:3000/"
  init: (store) ->
    @_super()
    @store = store
)






Mana.WebSocketAdapter = DS.ActiveModelAdapter.extend({

  init: ->
    # HACK is there some better way to get the default store?
    @store = Mana.__container__.lookup('store:main')
    @ws = new WebSocket("ws://localhost:3000/")

    # callbacks
    @ws.onopen = ->
      console.log "Websocket connected"

    @ws.onclose = ->
      console.log "Websocket closed"

    @ws.onmessage = (msg) =>
      json =  JSON.parse(msg.data)
      @store.update('card',json.card)

  updateRecord: (store,type,record) ->
    attrs = {}
    if type == Mana.Card
      attrs['card'] =  record.toJSON(includeId: true)
      @ws.send(JSON.stringify(attrs))
    else
      throw "Don't know how to send #{type} via Websocket"

    # fake promise as it happens synchronously :/
    new Ember.RSVP.Promise((resolve, reject) ->
      resolve(null)
    )
})



Mana.ApplicationAdapter = Mana.WebSocketAdapter
