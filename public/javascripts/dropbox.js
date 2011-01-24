Dropbox = function(element) {
  this.element = element;
  Utils.setObjectToDom(this.element, this);
  this.initDOM();
}


Dropbox.prototype.tappingAllowed = function() {
  return false;
}

Dropbox.prototype.dropped = function(card,event,ui) {
  mc = new MoveCommand(card, this.element.attr('id'));
  mc.run();
  this.fixPosition(card);
  game.sendCommand(mc);
}

Dropbox.prototype.shuffle = function() {
  var box = this;
  run_exclusively(function() {
    box.element.shuffle();
    spread_cards(box.element, 5, box.element.width());
    MessageCommand.createAndRun('Shuffled the library');
//      box.element.children('.card').each(function () { box.fixPosition(this.object()); });
  });
}


Dropbox.prototype.uncoverAll = function() {
  var that = this.element;

  run_exclusively(function() {
    that.children('.card').each(function() {
      this.object().turnOverLocally();
    });

    MessageCommand.createAndRun('Browsing the library');
  });
}


Dropbox.prototype.dropLocally = function(card) {
  card.element.appendTo(this.element);
  this.fixPosition(card);
}


Dropbox.prototype.fixPosition = function(card) {
  p = this.element.offset();
  p.top += 5;
  p.left += 5;
  card.element.offset(p);
}


Dropbox.prototype.initDOM = function() {

    this.element.droppable({
      scope: 'cards',
      hoverClass: 'card-over',
      drop: function(event,ui) {
        card = ui.draggable.object();
        this.object().dropped(card,event,ui);
      }
    });
}