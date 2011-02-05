mutex = false;


Dropbox.prototype.pack_cards = function () {
  container = this.element;

  var pos = container.offset();
  pos.top += 5;
  pos.left += 5;
    
  $(container).children('.card').each(function(i) {
    var card = $(this);
    card.offset(pos).css('z-index', 'auto');
  });
}


Dropbox.prototype.spread_cards = function(top, width) {
  container = this.element;

  var padding = 10;
  var count = $(container).children('.card').length;
  var h_start = 35;
  var w_per_card = CARD_W + padding;
  var h_per_card = CARD_H + padding;
  var columns = Math.floor(width / w_per_card);
  var x, y, position;

  $(container).children('.card').reverse().each(function(i) {
    x = Math.floor(i % columns);
    y = Math.floor(i / columns);
    position = $(container).offset();

    position.top += h_start + padding + y * h_per_card;
    position.left += padding + w_per_card * x;

    $(this).offset(position); //.css('z-index', i);
  });

  container.css('height', h_start + (y+1) * h_per_card);
}


Dropbox.prototype.pack_unpack = function() {
  if (!mutex) {
    mutex = true;
    var box = this.element;

    if (box.hasClass('unpacked')) {
      pack(box);
    } else {
      unpack(box);
    }

    box.toggleClass('unpacked');
  }
}


function switch_parent(box, parent) {
  var old = box.offset();
  box.detach();
  box.appendTo(parent);
  box.offset(old);
}

function unpacked_length(box) {
    var max = 1000;
    var needed = (box.children('.card').length - 1) * (SPACING + CARD_W);
//    return Math.max(Math.min(max,needed), 0)
  return 200;
}

function pack(box) {
  box.object().pack_cards();

  var old = box.object().old_position;
  box.offset(old);
  box.width(old.width);
  box.height(old.height);

  mutex = false;
}

function unpack(box) {
  var offset = box.offset();
  var width = 920;

  var old = box.offset();
  old.width = box.width();
  old.height = box.height();
  box.object().old_position = old;

  box.offset({ top: 200, left: 100 });
  box.css('width',width);
  box.object().spread_cards(5, width);
  mutex = false;
}

