TapCommand = function(card,state) {
  this.action = 'Tap';
  this.card_id = card.id;
  this.state = !card.isTapped();
}

TapCommand.prototype.run = function() {
  game.message('Player X tapped ' + this.card_id + this.state);
  Card.find(this.card_id).tap(this.state);
}




