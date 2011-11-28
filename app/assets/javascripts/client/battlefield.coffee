class Battlefield extends Backbone.Collection
  model : Card

  put: (card) =>
    card.collection.remove(card)
    card.set(position: "grid-0-0-#{card.get('user_id')}", { silent: true })
    @add(card)
    card.save()
    false

  initialize: =>
    @id = "battlefield"
    CardCollection.all[@id] = this

window.Battlefield = Battlefield
new Battlefield();