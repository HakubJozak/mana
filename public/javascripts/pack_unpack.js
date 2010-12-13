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

function pack_unpack(box_id, placeholder_id) {
  if (!mutex) {
    mutex = true;
    var box = $('#' + box_id);
    var placeholder = $('#' + placeholder_id);
    var unpacked = (placeholder.length != 0);
    var offset = box.offset();
    var width = unpacked_length(box);
    var effect;

    //$(this).text(unpacked ? 'Show' : 'Hide');

    if (unpacked) {
      effect = { left: box.object().old_position.left, 
                 width: box.object().old_position.width }

      var parent = placeholder.parent();
      placeholder.remove();

      var old = box.offset();
      box.detach();
      box.appendTo(parent);
      box.offset(old);
      pack_cards(box,5,0)
    } else {
      var effect = { left: '-=' + width, width: '+=' + width }

      var old_position = box.position();
      old_position.width = box.width();
      box.object().old_position = old_position;

      $('<div id="' + placeholder_id + '" class="box"></div>').insertBefore(box);
      box.prependTo('#battlefield');
      box.offset(offset);
      spread_cards(box,5,width + box.width());
    }

    box.animate(effect, function () { mutex = false; });
  }
}


$(document).ready(function() {
 $('#show-graveyard-button').click(function() {
   pack_unpack('graveyard','graveyard-placeholder');
 });

 $('#show-exile-button').click(function() {
   pack_unpack('exile','exile-placeholder');
 });

});

