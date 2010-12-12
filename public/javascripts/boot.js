CARD_W = 120;
CARD_H = 170; 
SPACING = 6;

$.fn.reverse = [].reverse;


function switch_parent(box, parent) {
  var old = box.offset();
  box.detach();
  box.appendTo(parent);
  box.offset(old);
}


function pack_cards(container) {
  var pos = container.offset();
  pos.top += 5;
  pos.left += 5;
    
  $(container).children('img').each(function(i) {
    $(this).offset(pos).css('z-index', 1000 - i);
  });
}


function spread_cards(container, top, width) {
  var padding =  parseInt($(container).css('padding-left'));
  var top_padding =  parseInt($(container).css('padding-top'));
  var count = $(container).children('img').length;
  var w = (width != null) ? width : $(container).width();
    
  var per_card = (w - padding) / count;

    $(container).children('img').each(function(i) {
      position = $(container).offset();
      position.top += top;
      position.left += padding + per_card * i;
      $(this).css('position', 'absolute')
            .offset(position)
            .css('z-index', $(this).prev().css('z-index') + 1);
    });      
}

function unpacked_length(box) {
    var max = 1000;
    var needed = (box.children('img').length - 1) * (SPACING + CARD_W);
    return Math.max(Math.min(max,needed), 0)}


mutex = false;

function pack_unpack() {
  if (!mutex) {
    mutex = true;
    var box = $('#graveyard');
    var unpacked = ($('#placeholder').length != 0);
    var offset = box.offset();
    var width = unpacked_length(box);
    var effect;
    var after;

    $(this).text(unpacked ? 'Show' : 'Hide');

    if (unpacked) {
      effect = { left: old_position.left  , width: old_position.width }

      var parent = $('#placeholder').parent();
      $('#placeholder').remove();

      var old = box.offset();
      box.detach();
      box.appendTo(parent);
      box.offset(old);
      pack_cards(box,5,0)
    } else {
      var effect = { left: '-=' + width, width: '+=' + width }

      old_position = box.position();
      old_position.width = box.width();

      $('<div id="placeholder" class="box"></div>').insertBefore(box);
      box.prependTo('#battlefield');
      box.offset(offset);
      spread_cards(box,5,width + box.width());
    }

    box.animate(effect, function () { mutex = false; });
  }
}



controlKeyDown = false;

$(document).ready(function() {

  preventDefaults();

  Dropbox.initialize();

  Object.prototype.object = function() {
    return Utils.getObjectFromDom(this);
  }

  $(document).keydown(function(e) {
    if (e.keyCode == 17) {
      controlKeyDown = true;
    }
  });

  $(document).keyup(function(e) {
    if (e.keyCode == 17) {
      controlKeyDown = false;
    }
  });

  $('#show-graveyard-button').click(pack_unpack);
});


function preventDefaults() {
    var labels = 'img, #library';

    $(labels).click(function(event) {
        event.preventDefault();
    });

    $(labels).mousedown(function(event) {
        event.preventDefault();
    });
}
