#= require jquery
#= require jquery.ui.draggable
#= require jquery.ui.droppable
#= require handlebars
#= require ember
#= require ember-data
#= require_self

#= require ./lib/jquery_ui_base
#= require ./lib/draggable
#= require ./lib/droppable

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
    @ws = new WebSocket(@uri)

    # callbacks
    @ws.onopen = ->
      console.log "Websocket connected"

    @ws.onclose = ->
      console.log "Websocket closed"

    @ws.onmessage = (msg) =>
      json =  JSON.parse(msg.data)
      @store.update('card',json.cards)
)


# Mana.WebSocketAdapter = DS.ActiveModelAdapter.extend({
#   socket: undefined

#   init: ->
#     @socket = new Mana.WebSocketHandler('ws://localhost:3000/')
#     @_super()

#   find: (store,type,id) ->
#     @_super(store,type,id)

#   findAll: (store,type) ->
#     @_super(store,type)

#   createRecord: (store,type,record) ->
#     @_super(store,type,record)
# })
# Mana.ApplicationAdapter = Mana.WebSocketAdapter



# ws = new WebSocket('ws://localhost:3000/');
# ws.onopen = ->
#   console.debug "connected"

# ws.onerror = (e) ->
#   console.debug "error occured"

# ws.onmessage = (msg) ->
#   console.debug JSON.parse(msg.data)
