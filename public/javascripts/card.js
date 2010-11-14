Card = function(image) {
  this.covered = false;
  this.tappable = true;
  this.element = image;
  this.picture = image.attr('src');
  console.log(this.picture);
  this.initDOM();
}

Card.initialize = function() {
    $('.card').each(function(i) {
        card = new Card($(this));
    });
}

Card.prototype.container = function() {
  return Utils.getObjectFromDom(this.element.parent());
}

Card.prototype.tap = function() {
  if (this.container().tappingAllowed()) {
    this.element.toggleClass('tapped');
  }
}

Card.prototype.turnOver = function(cover) {
  this.covered = (cover != null) ? cover : !this.covered;
  this.element.attr('src', this.covered ?  "/images/back-side.jpg" : this.picture);
}

Card.prototype.isCovered = function() {
  return this.element.hasClass('covered');
}

Card.prototype.dropped = function() {
  this.tappable = false;
  this.element.removeClass('tapped');  
}


Card.prototype.initDOM = function() {
  Utils.setObjectToDom(this.element, this);
  toggleDragged = function() { $(this).toggleClass('dragged'); }

    this.element.draggable( { 
      snap: true,
      start: toggleDragged,
      stop: toggleDragged,
      scroll: false,
      revert: 'invalid',
      containment: '#desk',
      snapMode: 'inner',
      stack: '#table > *',
      zIndex: 9999
    });

    this.element.click(_('tap'));
    this.element.rightClick(_('turnOver'));
}

