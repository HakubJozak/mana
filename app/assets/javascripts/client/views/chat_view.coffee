class ChatView extends Backbone.View

  initialize: =>
    @el = $('#top-panel')
    @el.submit(@submit)
    @template = _.template($("#message-template").html())

    @model.bind 'add', @message_added
    Controls.current.bind 'key:m', @focus

  focus: =>
    input = @$('.chat-input').focus();

  message_added: (message) =>
    li = $(@template(message))
    @$('.message-list').prepend(li)

  submit: =>
    input = @$('form .chat-input');

    # TODO: replace by create method
    message = new Message({ text: input.val() });
    @model.add(message, { silent: true })
    message.save()

    input.val('');
    input.blur();
    false

window.ChatView = ChatView