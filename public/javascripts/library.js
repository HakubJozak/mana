$(document).ready(function() {
  $('#library').click(function() {
    hand = Utils.getObjectFromDom($('#hand'));
    library.drawCard();
  })

  var library = new Library();

});


Library = function() {
  this.cards_urls = [ 'http://localhost:3000/images/cards/1.jpg',
                      'http://localhost:3000/images/cards/2.jpg',
                      'http://localhost:3000/images/cards/3.jpg'  ];

}

Library.prototype.drawCard = function() {
  hand = Utils.getObjectFromDom($('#hand'));

  if (this.cards_urls.length > 0) {
    card = new Card(this.cards_urls.pop());
    hand.showHand();
    hand.addCard(card);
  } else {
    // TODO: make it better
    alert('Out of cards');
  }
}
