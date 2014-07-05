Mana.ApplicationController = Ember.ObjectController.extend({
  actions:
    send_message: ->
      text = @get('new_chat_message')
      if text? and text.length > 0
        player_id = @get('current_player.id')
        @store.createRecord('message',text: text, player: @get('current_player')).save()
        @set('new_chat_message')
      false

})
