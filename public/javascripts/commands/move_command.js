MoveCommand = function(card, new_parent) { 
  this.position = card.element.offset();
  this.action = 'Move';
  this.new_parent = new_parent;

  // TODO: don't send so much info by default
  this.card = { 
    id: card.id,
    tapped: card.tapped,
    name: card.name,
    covered: card.covered,
    image_url : card.e().attr('src'),
    picture : card.picture
  };
}


  // TODO: REFACTOR this hackish multi-purpose thing
MoveCommand.prototype.run = function() {
  // TODO: remove
  var owner_id = 'user-' + this.sid;
  var card = Card.find_or_create_opponent_card(this.card, owner_id);
  var position = this.position;
  var animate = this.remote;
  var parent = $('#' + this.new_parent);
  var c = card.element;

  console.info(card);

  // TODO: refactor this hard-coded ultra ad-hoc code
  if (this.remote) {
    if (this.new_parent == 'hand') {
      c.fadeOut(function() { $(this).remove() });
      return;
    } else if (this.new_parent != 'battlefield') {
      // TODO: should be processed on server
      parent = $('#' + owner_id + ' .' + this.new_parent + '-remote') ;
      position = parent.offset();
    }
  }

  if (c.parent().attr('id') != parent.attr('id')) {
//      var p = (parent.object && (parent.object().unpacked) != null) ? parent.object().unpacked() : false;
      switch_parent(c, parent, false);
  };
  

  if (animate) {
    o = parent.offset()
    var top = position.top - o.top;
    var left = position.left - o.left;
    c.animate({ "top": top, "left": left }, animate);
  } else {
    c.offset(position);
  }

}