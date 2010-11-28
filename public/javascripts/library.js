$(document).ready(function() {
  $('#library').click(function() {
    hand = Utils.getObjectFromDom($('#hand'));
    library.drawCard();
  })

  var library = new Library();
});


Library = function() {
  this.cards_urls = [ 
    { url: 'http://localhost:3000/images/cards/1.jpg', id: 42 },
    { url: 'http://localhost:3000/images/cards/2.jpg', id: 43 },
    { url: 'http://localhost:3000/images/cards/3.jpg', id: 44 },
    { url: 'http://localhost:3000/images/cards/4.jpg', id: 45 }
  ];
}

Library.prototype.drawCard = function() {
  hand = Utils.getObjectFromDom($('#hand'));

  if (this.cards_urls.length > 0) {
    hand.showHand();

    params = this.cards_urls.pop()
    card = new Card( params.url, params.id);

    hand.addCard(card);
  } else {
    // TODO: make it better
    alert('Out of cards');
  }
}
