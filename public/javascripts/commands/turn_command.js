TurnCommand = function(card) {
  this.action = 'Turn';
  this.card_id = card.id;
  this.covered = !card.isCovered();

  if (this.covered == false) {
    this.picture = card.picture;
  }
}

TurnCommand.prototype.run = function() {
  var card = Card.find(this.card_id);

  if (card) {
    card.turnOverLocally(this.covered)
  }
}




