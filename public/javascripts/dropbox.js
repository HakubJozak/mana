Dropbox = function(element) {
  this.element = element;
  Utils.setObjectToDom(this.element, this);
  this.initDOM();
}

Dropbox.initialize = function() {
    $('#graveyard, #exile').each(function(i) {
        new Dropbox($(this));
    });
}

Dropbox.prototype.tappingAllowed = function() {
  return false;
}

Dropbox.prototype.dropped = function(card,event,ui) {
  this.fixPosition(card);
  mc = new MoveCommand(card, this.element.attr('id'));
  mc.run();
  game.sendCommand(mc);
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
        box = Utils.getObjectFromDom(this);
        card = Utils.getObjectFromDom(ui.draggable);
        box.dropped(card,event,ui);
      }
    });
}