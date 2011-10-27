class Message extends Backbone.Model
  text: => @get('text')

  initialize: =>
    @user = User.all.get(@get('user_id')) || User.local
    @set({ user_id: @user.id })
    @set(clazz: 'Message')

  constructor: (attrs) ->
    super(attrs)


class MessageCollection extends Backbone.Collection
  model: Message


Message.all = new MessageCollection()

window.Message = Message
window.MessageCollection = MessageCollection