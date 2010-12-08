// -*- mode: javascript; tab-width: 2; -*-

Card = function(image_url, id) {
  var image = $('<img src="' + image_url + '" class="card" id="card-' + id + '" />');
  this.id = id;
  this.covered = false;
  this.element = image;
  this.picture = image.attr('src');
  this.initDOM();
}


Card.find = function(id) {
  var element = $('#card-' + id);
  return (element == null) ? null : element.object();
}

Card.find_or_create_opponent_card = function(params,owner_id) {
  var card = Card.find(params.id);

  if (card == null) {
    // test existence and fetch if card not supplied?
    card = new Card(params.image_url, params.id);
    card.element.addClass(owner_id)
                .addClass('opponent')
                .attr('style','position: absolute');
  }

  return card;
}


Card.prototype.container = function() {
  return this.element.parent().object();
}

Card.prototype.isTapped = function() {
  return this.element.hasClass('tapped');
}

Card.prototype.toggleTapped = function(event) {
  if (this.container().tappingAllowed()) {
      tc = new TapCommand(this);
      tc.run();
      game.sendCommand(tc);
  }
}

Card.prototype.turnOver = function(cover) {
    tc = new TurnCommand(this);
    tc.run();
    game.sendCommand(tc);
}

Card.prototype.isCovered = function() {
   return this.covered;
}


Card.prototype.showDetail = function() {
    var detail = this.element.clone();

    $('body').append(detail);
    
    detail.css('z-index',10000)
        .attr('src', this.picture)
        .offset(this.element.offset())
        .removeClass('card')
        .addClass('card-detail')
        .animate(Card.detailAnimation('+'), 200)

    detail.click(function() {
        $(this).unbind('click')
               .animate(Card.detailAnimation('-'), 200, function() {
                 $(this).remove();
               });
    });
}


Card.detailAnimation = function(resize) {
    var reposition = (resize == '+') ? '-' : '+';

    return {
             left: reposition + '=60',
             top: reposition + '=85',
             height: resize + '=170',
             width: resize + '=120'
          }
}

Card.prototype.initDOM = function() {
  Utils.setObjectToDom(this.element, this);
  var toggleDragged = function() { $(this).toggleClass('dragged'); }

    this.element.draggable( { 
      scope: 'cards',
      snap: '.card',
      start: toggleDragged,
      stop: toggleDragged,
      scroll: true,
      revert: 'invalid',
      containment: '#desk',
      snapMode: 'inner',
      stack: '.card',
      zIndex: 9999
    });

  this.element.rightClick(_('toggleTapped'));

  this.element.click(function(event) {
    card = $(this).object();

    if (controlKeyDown) {
      card.turnOver();
    } else {
      card.showDetail();
    }

    event.stopPropagation();
  });


    // this.element.hover(function() {
    //     card = $(this);
    //     controls = card.append('<p>PRDEL</p>');
    //     controls.offset(card.offset());
    //     // window.clearTimeout(c.timeout);
    //     // cardControls = function () {
    //     // }
    //     // window.setTimeout(2000, cardControls)
    // });
}

