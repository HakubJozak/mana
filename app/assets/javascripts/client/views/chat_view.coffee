class ChatView extends Backbone.View

  initialize: =>
    @el = $('#top-panel form')
    @el.submit(@submit)
    Controls.current.bind 'key:m', @focus

  focus: =>
    input = @$('.chat-input').focus();

  submit: =>
    input = @$('.chat-input');

    # TODO: replace by create method
    message = new Message({ text: input.val() });
    @model.add message
    message.save()

    input.val('');
    input.blur();
    false

window.ChatView = ChatView