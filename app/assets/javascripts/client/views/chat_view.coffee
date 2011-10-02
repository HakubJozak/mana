class ChatView extends Backbone.View

  initialize: ->
    @el = $('#chat-bar')
    @el.draggable()
       .keyup(@close_or_submit)
       .children('input')
       .blur()

  close_or_submit: (event) =>
    if event.keyCode == 27
      @close_chat()
    else if event.keyCode == 13
      @submit_chat()
      @close_chat()

  close_chat: ->
    @el.hide().children('input').blur()

  submit_chat: ->
    input = @el.find('input');

    # TODO: replace by create method
    message = new Message({ text: input.val() });
    @model.add message
    message.save()

    input.val('');
    false

window.ChatView = ChatView