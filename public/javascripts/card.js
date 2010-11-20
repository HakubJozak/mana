// -*- mode: javascript; tab-width: 2; -*-

Card = function(image_url, id) {
  image = $('<img src="' + image_url + '" class="card card-size" id="card-' + id + '" />');

  this.id = id;
  this.covered = false;
  this.tappable = true;
  this.element = image;
  this.picture = image.attr('src');
  this.initDOM();
}


Card.find = function(id) {
  return $('#card-' + id).object();
}


Card.prototype.container = function() {
  return Utils.getObjectFromDom(this.element.parent());
}

Card.prototype.toggleTapped = function(event) {
  if (this.container().tappingAllowed()) {
    state = !this.element.hasClass('tapped')
    this.tap(state);
    game.tapped(this, state);
  }
}

Card.prototype.tap = function(tapped) {
    if (tapped) {
      this.element.addClass('tapped');
    } else {
      this.element.removeClass('tapped');
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

Card.prototype.showDetail = function(event) {
   detail = this.element.clone();
    $('body').append(detail);
    
    detail.css('z-index',10000)
        .offset(this.element.offset())
        .removeClass('card')
        .animate(Card.detailAnimation('+'), 200);

    detail.click(function() {
        $(this).unbind('click')
               .animate(Card.detailAnimation('-'), 200, function() {
                 $(this).remove();
               });
    });

    event.stopPropagation();
}

Card.detailAnimation = function(resize) {
    reposition = (resize == '+') ? '-' : '+';

    return {
             left: reposition + '=60',
             top: reposition + '=85',
             height: resize + '=170',
             width: resize + '=120'
          }
}

Card.prototype.initDOM = function() {
  Utils.setObjectToDom(this.element, this);
  toggleDragged = function() { $(this).toggleClass('dragged'); }

    this.element.draggable( { 
      scope: 'cards',
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
  this.element.rightClick(_('toggleTapped'));
}

