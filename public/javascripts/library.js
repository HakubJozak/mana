Library = function() {
  this.element = $('#library')
}


Library.prototype.update = function(cards) {
  var lib = this.element;

  $(cards).each(function(i,params) {
    card = new Card(params);
    card.turnOverLocally(true);
    card.element.css('position', 'absolute')
    $('#library').object().dropLocally(card);
  });
}
