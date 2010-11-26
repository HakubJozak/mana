MoveCommand = function(card, new_parent, animate) { 
  this.position = card.element.offset();
  this.action = 'Move';
  this.card_id = card.id;
  this.new_parent = new_parent;
}

MoveCommand.prototype.run = function() {
  var parent = $('#' + this.new_parent);
  var card = Card.find(this.card_id);
  card.moveTo( this.position, parent, this.remote);
}


