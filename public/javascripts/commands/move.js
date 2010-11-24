MoveCommand = function(card, new_parent, animate) {
  this.action = 'Move';
  this.card_id = card.id;
  this.position = card.element.offset();
  this.new_parent = new_parent;
}

MoveCommand.prototype.run = function() {
  console.info(this.remote);
  Card.find(this.card_id).moveTo(this.position, 
                                 $('#' + this.new_parent), 
                                 this.remote);
}


