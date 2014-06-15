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
