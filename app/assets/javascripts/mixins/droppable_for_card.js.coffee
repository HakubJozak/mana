Mana.DroppableForCard = Ember.Mixin.create Mana.Droppable,
  drop: (event,ui) ->
    if ui
      card = ui.draggable.data('card')
      before = ui.draggable.data('container')
      now = @get('holder')

      card.moveTo(now)
      card.save()

      # card.set 'position', now.next_position()
      # card.set('slot_id',now.get('id'))

      # before.get('cards').removeObject(card)
      # now.get('cards').pushObject(card)

      # before.save()
      # now.save()

      console.debug "Card #{card.get('id')} dropped from #{before.get('id')} to #{now.get('id')}"
