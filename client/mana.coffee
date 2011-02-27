$(document).ready ->
  # card = new Card
  #          id: 42
  #          name: 'Elvish Archdruid'
  #          image: '/images/cards/1.jpg'

  # $('#battlefield').append(view.el)
  CardCollection.all = new CardCollection()

  Chat.instance = new Chat()
  new ChatView({ model: Chat.instance })



