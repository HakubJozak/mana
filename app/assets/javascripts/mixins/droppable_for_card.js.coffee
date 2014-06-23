Mana.DroppableForCard = Ember.Mixin.create Mana.Droppable,
  drop: (event,ui) ->
    if ui
      card = ui.draggable.data('card')
      before = ui.draggable.data('container')
      now = @get('holder')

      @after_drop(card)

      card.set('position',@position)
      card.set('slot_id',now.get('id'))

      before.get('cards').removeObject(card)
      now.get('cards').pushObject(card)

      before.save()
      now.save()
      card.save()
