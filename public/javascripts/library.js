$(document).ready(function() {
  $('#library').click(function() {
    hand = Utils.getObjectFromDom($('#hand'));
    library.drawCard();
  });

  library = new Library();
});


Library = function() {
  this.cards = [];
}

Library.prototype.update = function(cards) {
  this.cards = cards;
}


Library.prototype.drawCard = function() {
  hand = Utils.getObjectFromDom($('#hand'));

  if (this.cards.length > 0) {
    hand.showHand();

    params = this.cards.pop()
    card = new Card( params.image_url, params.id);

    hand.addCard(card);
  } else {
    // TODO: make it better
    game.message('No more cards in the library.');
  }
}
