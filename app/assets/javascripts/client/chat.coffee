class Message extends Backbone.Model

  @action: (txt) ->
    m = new Message(text: txt)
    m.save()

  text: => @get('text')

  initialize: =>
    @user = User.all.get(@get('user_id')) || User.local
    @set({ user_id: @user.id })
    @set(clazz: 'Message')

  text: =>
    @escape('text')

  constructor: (attrs) ->
    super(attrs)


class MessageCollection extends Backbone.Collection
  model: Message


Message.all = new MessageCollection()

window.Message = Message
window.MessageCollection = MessageCollection