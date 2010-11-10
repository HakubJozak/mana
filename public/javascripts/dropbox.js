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

Dropbox.prototype.dropped = function(card) {
  e = card.element;
  e.detach();
  e.appendTo(this.element);
  e.offset( this.element.offset() );
}

Dropbox.prototype.initDOM = function() {

    this.element.droppable({
      hoverClass: 'selected',
      drop: function(event,ui) {
          box = Utils.getObjectFromDom(this);
          card = Utils.getObjectFromDom(ui.draggable);
          box.dropped(card);
      }
    });
}