mutex = false;


function switch_parent(box, parent) {
  var old = box.offset();
  box.detach();
  box.appendTo(parent);
  box.offset(old);
}


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
  var w = (width != null) ? width : $(container).width();
  var w_per_card = CARD_W + padding;
  var h_per_card = CARD_H + padding;
  var columns = Math.floor(w / w_per_card) - 1;
  var x, y, position;

  $(container).children('.card').reverse().each(function(i) {
    x = i % columns;
    y = Math.floor(i / columns);
    position = $(container).offset();

    position.top += padding + y * h_per_card;
    position.left += padding + w_per_card * x;

    $(this).offset(position).css('z-index', i);
  });

  container.css('height', (y+1) * h_per_card);
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
  var offset = box.offset();
  var width = 920; // unpacked_length(box);
  var old = box.position();

  var effect = { 
    top: 20,
    left: 20,
    width: width
  }

  // old.width = box.width();
  //old.height = box.height();
  box.object().old_position = old;

  $('<div id="' + placeholder_id + '" class="box"></div>').insertBefore(box);
  box.prependTo('#battlefield');
  box.offset(offset);
  box.object().spread_cards(5,width + box.width());

  box.animate(effect, function () { mutex = false; });
}


function pack_unpack(box_id, placeholder_id) {
  if (!mutex) {
    mutex = true;

    var box = $('#' + box_id);
    var unpacked = ($('#' + placeholder_id).length != 0);

    if (unpacked) {
      pack(box, placeholder_id);
    } else {
      unpack(box, placeholder_id);
    }
  }
}

     

