class Message extends Backbone.Model
  text: => @get('text')

  initialize: =>
    @user = User.all.get(@get('user_id')) || User.local
    @set({ user_id: @user.id })

  constructor: (attrs) ->
    super(attrs)


class Chat extends Backbone.Collection
  model: Message

  message_arrived: (msg) =>
    @add(msg)

window.Chat = Chat