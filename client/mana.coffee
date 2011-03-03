$(document).ready ->
  CardCollection.all = new CardCollection()

  Chat.instance = new Chat()
  new ChatView({ model: Chat.instance })

  info = new InfoView()
  InfoView.instance = info
  Chat.instance.bind 'add', info.render



