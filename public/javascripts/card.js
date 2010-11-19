// -*- mode: javascript; tab-width: 2; -*-

Card = function(image) {
  if (typeof(image) == 'string') {
    image = $('<img src="' + image + '" class="card card-size" />');
  }

  this.covered = false;
  this.tappable = true;
  this.element = image;
  this.picture = image.attr('src');
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
  this.element.attr('src', this.covered ?  "/images/back.jpg" : this.picture);
}

Card.prototype.isCovered = function() {
  return this.element.hasClass('covered');
}

Card.prototype.dropped = function() {
  this.tappable = false;
  this.element.removeClass('tapped');  
}

Card.prototype.showDetail = function() {
   detail = this.element.clone();
    $('body').append(detail);
    
    position = this.element.offset();
    position.left -= 60;
    position.top -= 85;

    detail.removeClass('card-size')
        .css('z-index',10000)
        .css('height','340px')
        .css('width','240px')
        .offset(position);

    detail.click(function() {
        $(this).remove();
    });
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
      stack: '.card',
      zIndex: 9999
    });

  this.element.click(_('showDetail'));
  this.element.rightClick(_('tap'));
}

