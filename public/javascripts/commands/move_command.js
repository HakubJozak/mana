MoveCommand = function(card, new_parent, animate) { 
  this.position = card.element.offset();
  this.action = 'Move';
  this.new_parent = new_parent;
  this.card = { 
    id: card.id,
    image_url : card.element.attr('src')
  };
}


MoveCommand.prototype.run = function() {
  var owner_id = Game.user_dom_id({ id: this.sid })
  var card = Card.find_or_create_opponent_card(this.card, owner_id);
  var position = this.position;
  var animate = this.remote;
  var parent = $('#' + this.new_parent);
  var c = card.element;

  if (this.remote) {
    if (this.new_parent == 'hand') {
      c.fadeOut(function() { $(this).remove() });
      return;
    } else if (this.new_parent != 'battlefield') {
      parent = $('#' + owner_id + ' .' + this.new_parent + '-remote') ;
      position = parent.offset();
    }
  }

  // TODO: function switch_parent
    if (c.parent().attr('id') != parent.attr('id')) {
      old = c.offset();
      c.detach();
      c.appendTo(parent);
      c.offset(old);
    }

    if (animate) {
      o = parent.offset()
      var top = position.top - o.top;
      var left = position.left - o.left;
      c.animate({ "top": top, "left": left }, animate);
    } else {
      c.offset(position);
    }

}