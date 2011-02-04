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

    $(this).offset(position).css('z-index', i);
  });

  container.css('height', h_start + (y+1) * h_per_card);
}


Dropbox.prototype.pack_unpack = function() {
  if (!mutex) {
    mutex = true;

    var box = this.element;

    var placeholder_id = box.attr('id') + '-placeholder';
    var unpacked = ($('#' + placeholder_id).length != 0);

    if (unpacked) {
      box.find('.button-bar').hide();
      pack(box, placeholder_id);
    } else {
      box.find('.button-bar').show();
      unpack(box, placeholder_id);
    }
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
    return Math.max(Math.min(max,needed), 0)
}

function pack(box, placeholder_id) {
  var placeholder = $('#' + placeholder_id);
  
  old = box.object().old_position;

  var parent = placeholder.parent();
  placeholder.remove();

  switch_parent(box, parent);

  box.css('position', 'left');
  box.css('top', 'auto');
  box.css('left', old.left + 'px');
  box.css('width', 110);
  box.css('height', 170);
  // box.animate(effect, function () { mutex = false; });
  box.object().pack_cards();
  mutex = false;
}

function unpack(box, placeholder_id) {
//  var box = $('#' + box_id);
  var offset = box.offset();
  var width = 920; // unpacked_length(box);
  var old = box.position();

  var effect = { 
    top: 200,
    left: 20,
    width: width
  }

  box.object().old_position = old;

  $('<div id="' + placeholder_id + '" class="box"></div>').insertBefore(box);
  box.prependTo('#battlefield');
  box.offset(offset);
  box.object().spread_cards(5, width);
  box.animate(effect, function () {
    mutex = false; 
  });
}

