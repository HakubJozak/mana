TapCommand = function(card,state) {
  this.action = 'Tap';
  this.card_id = card.id;
  this.state = !card.isTapped();
}

TapCommand.prototype.run = function() {
  var card = Card.find(this.card_id);

  if (this.state) {
    card.element.addClass('tapped');
  } else {
    card.element.removeClass('tapped');
  }
}




