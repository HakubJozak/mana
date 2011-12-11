class Battlefield extends Backbone.Collection
  model : Card

  put: (card) =>
    @put_on_position(card, "grid-0-0-#{card.get('user_id')}")
    false

  put_on_position: (card, position) =>
    old = card.collection
    old.remove(card) if old
    next = @cards_in_cell(position).length
    card.set({ position: position, order: next }, { silent: true })
    @add(card)
    card.save()

  cards_in_cell: (position) =>
    @filter (card) ->
      card.position() == position

  # returns grid coordinates and stack order (i.e. [ grid-0-0-XXX, 2 ]
  # of an empty grid cell so that a new card can get them (see add token action)
  landing_coords: =>
    first = "grid-0-0-#{User.local.id}"
    return { order: @cards_in_cell(first).length, position: first }

  sort: ->
    true

  initialize: =>
    @id = "battlefield"
    CardCollection.all[@id] = this

window.Battlefield = Battlefield
new Battlefield();