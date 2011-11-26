class Battlefield extends Backbone.Collection
  model : Card

  put: (card) =>
    card.collection.remove(card)
    @add(card)
    card.save()
    false

  initialize: =>
    @id = "battlefield"
    CardCollection.all[@id] = this

window.Battlefield = Battlefield
new Battlefield();