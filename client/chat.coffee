class Message extends Backbone.Model
  text: -> @get('text')
  toString: -> @text()


class Chat extends Backbone.Collection
  model: Message
