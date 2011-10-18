class Battlefield extends Backbone.Collection
  model : Card

  initialize: =>
    @id = "battlefield"
    CardCollection.all[@id] = this

window.Battlefield = Battlefield