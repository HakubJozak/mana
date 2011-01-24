// -*- mode: javascript; tab-width: 2; -*-

Card = function(params) {
  var image = $('<img src="' + params.image_url + '" class="card" id="card-' + params.id + '" />');

  // TODO: do it better way
  this.id = params.id;
  this.url = params.url;
  this.name = params.name;
  this.covered = params.covered;
  this.picture = params.picture;

  this.element = image;
  this.initDOM();
}

Card.createToken = function(x,y) {
  var token = new Card({
      name: 'Token',
     id: 'token-' + 'USER_ID' + '-',
     picture: '/images/token.jpg'
  });

    token.element.offset({ top: x, left: y });
  return token;
}


Card.find = function(id) {
  var element = $('#card-' + id);
  return (element == null) ? null : element.object();
}

Card.find_or_create_opponent_card = function(params,owner_id) {
  var card = Card.find(params.id);

  if (card == null) {
    card = new Card(params);
    card.element.addClass(params.owner_id)
                .addClass('opponent')
                .attr('style','position: absolute');

    if (params.tapped) card.addClass('tapped');
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

Card.prototype.turnOverLocally = function(cover) {
  if (cover != null) {
    this.covered = cover;
  } else {
    this.covered = !this.covered;
  }

  this.element.attr('src', this.covered ?  "/images/back.jpg" : this.picture);
}

// TODO: remove
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
      start: toggleDragged(),
	    stop: toggleDragged(),
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

