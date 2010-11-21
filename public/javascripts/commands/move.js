MoveCommand = function(card) {
  this.action = 'Move';
  this.card_id = card.id;
  this.position = card.element.offset();
}

MoveCommand.prototype.run = function() {
  Card.find(this.card_id).move(this.position);
}
