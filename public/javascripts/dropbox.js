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
  card.dropped();
  e = card.element;
  e.detach();
  e.appendTo(this.element);

  position = this.element.offset()
  position.top += 5;
  position.left += 5;

  e.offset( position );
}

Dropbox.prototype.initDOM = function() {

    this.element.droppable({
      hoverClass: 'card-over',
      drop: function(event,ui) {
        box = Utils.getObjectFromDom(this);
        card = Utils.getObjectFromDom(ui.draggable);
        box.dropped(card,event,ui);
      }
    });
}