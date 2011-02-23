MoveCommand = function(card, new_parent) { 
  this.position = card.element.offset();
  this.action = 'Move';
  this.new_parent = new_parent;

  // TODO: don't send so much info by default
  this.card = card;
// { 
//     id: card.id,
//     tapped: card.tapped,
//     name: card.name,
//     covered: card.covered,
//     image_url : card.element.find('img').attr('src'),
//     picture : card.picture,
//     power: card.power,
//     toughness: card.toughness,
//     counters: card.counters,
//     covered: card.covered,
//   };
}


  // TODO: REFACTOR this hackish multi-purpose thing
MoveCommand.prototype.run = function() {
  // TODO: remove
  var owner_id = 'user-' + this.sid;
  var card = this.card // Card.find_or_create_opponent_card(this.card, owner_id);
  var position = this.position;
  var animate = this.remote;
  var parent = $('#' + this.new_parent);
  var c = card.element;

  // TODO: refactor this hard-coded ultra ad-hoc code
  if (this.remote) {
    if (this.new_parent == 'hand') {
      c.fadeOut(function() { $(this).remove() });
      return;
    } else if (this.new_parent != 'battlefield') {
      position = parent.offset();
    }
  }

  if (c.parent().attr('id') != parent.attr('id')) {
//      var p = (parent.object && (parent.ob().unpacked) != null) ? parent.ob().unpacked() : false;
      switch_parent(c, parent, false);
  };
  
  return;

  if (animate) {
    o = parent.offset();
    var top = position.top - o.top;
    var left = position.left - o.left;
    c.animate({ "top": top, "left": left }, animate);
  } else {
    c.offset(position);
  }

}