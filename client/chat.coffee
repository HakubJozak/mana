class Message extends Backbone.Model
  text: -> @get('text')

class Chat extends Backbone.Collection
  model: Message
