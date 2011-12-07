class ChatView extends Backbone.View

  initialize: =>
    @el = $('#top-panel')
    @el.submit(@submit)
    @el.draggable
      handle: '.handle'

    @el.resizable
      minHeight: 100
      minWidth: 100
      handles: 's,e,se'
      alsoResize: '.message-list'

    @$('.message-list').css('height','7em')
    @template = _.template($("#message-template").html())

    @model.bind 'add', @message_added
    User.all.bind 'change', @user_changed

    Controls.current.bind 'chat:toggle', @toggle
    @$('.close-button').click @close

  toggle: =>
    @el.toggle()
    @$('.chat-input').focus() # if visible!

  open: =>
    @el.fadeIn()
    @$('.chat-input').focus()

  close: =>
    @el.fadeOut()

  user_changed: (user) =>
    change = user.changedAttributes()

    if change.connected?
      state = if user.connected() then 'connected.' else 'disconnected.'
      @prepend({ user: user, message: state })
    else if change.lives?
      @prepend({ user: user, message: "has #{user.lives()} lives now." })

  card_changed: (card) =>
    card.info 'changed'

  message_added: (message) =>
    # TODO: remove that hack
    message.message = message.text()
    @prepend(message)

  prepend: (message) =>
    li = $(@template(message))
    @$('.message-list').prepend(li)

  submit: =>
    input = @$('form .chat-input');

    # TODO: replace by create method
    message = new Message({ text: input.val() });
    @model.add(message, { silent: true })
    message.save()

    input.val('');
    # input.blur();
    false

window.ChatView = ChatView