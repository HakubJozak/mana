Mana.DroppableForCard = Ember.Mixin.create Mana.Droppable,
  drop: (event,ui) ->
    if ui
      card = ui.draggable.data('card')
      before = ui.draggable.data('container')
      now = @get('holder')

      @after_drop(card)

      card.set('location',"#{@location_prefix}_#{@player_id}")
      card.set('position',@position)

      console.info card.get('location')

      before.removeObject(card)
      now.pushObject(card)

      card.save()
