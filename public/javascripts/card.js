Card = function(image) {
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

Card.prototype.tap = function() {
    this.element.toggleClass('tapped');
}

Card.prototype.turn = function() {
    
    if (this.isCovered()) {
        this.element.removeClass('covered')
                .attr('src', this.picture);
    } else {
        this.element.addClass('covered')
                .attr('src', "/images/back-side.jpg");
    }
}

Card.prototype.isCovered = function() {
    return this.element.hasClass('covered');
}


Card.prototype.initDOM = function() {
  Utils.setObjectToDom(this.element, this);

  this.element.addClass('card-size');

  toggleDragged = function() { $(this).toggleClass('dragged'); }

    this.element.draggable( { 
      snap: true,
      start: toggleDragged,
      stop: toggleDragged,
      snapMode: 'inner',
      stack: '#table > *',
      zIndex: 9999
    });

    this.element.click(_('tap'));
    this.element.rightClick(_('turn'));

    // img.mousewheel(function(event, delta) {
    //   //$(this).toggleClass('small');
    //   console.log(delta);
    // });
}

