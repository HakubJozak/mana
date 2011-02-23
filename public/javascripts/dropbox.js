Dropbox = function(element) {
  this.element = element;
  Utils.setObjectToDom(this.element, this);

  this.element.droppable({
      scope: 'cards',
      greedy: true,
      hoverClass: 'card-over',
      drop: function(event,ui) {
        card = ui.draggable.ob();
        $(this).ob().dropped(card,event,ui);
      }
  });
}

Dropbox.prototype.tappingAllowed = function() {
  return false;
}


Dropbox.prototype.shuffle = function() {
  var box = this;
  run_exclusively(function() {
    box.element.shuffle('.card');
    box.spread_cards(5, box.element.width());
    MessageCommand.createAndRun('Shuffled the library');
  });
}

Dropbox.prototype.coverAll = function(mode) {
  var that = this.element;

  run_exclusively(function() {
    that.children('.card').each(function() {
      $(this).ob().turnOverLocally(mode);
    });
  });
}

Dropbox.prototype.unpacked = function() {
  return this.element.hasClass('unpacked');
}


Dropbox.prototype.dropLocally = function(card) {
  if (this.unpacked()) {
    card.element.appendTo(this.element);
  } else {
    card.element.prependTo(this.element);
  }

  this.fixPosition(card);
}

Dropbox.prototype.dropped = function(card,event,ui) {
//  mc = new MoveCommand(card, this.element.attr('id'));
//  mc.run();
  this.fixPosition(card);
//  game.sendCommand(mc);
}


Dropbox.prototype.fixPosition = function(card) {
  if (this.unpacked()) {
    this.spread_cards(5, this.element.width());
  } else {
    p = this.element.offset();
    p.top += 5;
    p.left += 5;
    card.element.offset(p);
  }
}
