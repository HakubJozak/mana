class Message extends Backbone.Model

  @action: (txt) ->
    m = new Message(text: txt)
    m.save()

  initialize: =>
    @user = User.all.get(@get('user_id')) || User.local
    @set({ user_id: @user.id })
    @set(clazz: 'Message')

  text: =>
    @detect_links(@escape('text'))

  detect_links: (text) =>
    regexp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
    return text.replace(regexp,"<a class='link' href='$1' target='_blank' >$1</a>")

  constructor: (attrs) ->
    super(attrs)


class MessageCollection extends Backbone.Collection
  model: Message


Message.all = new MessageCollection()

window.Message = Message
window.MessageCollection = MessageCollection