$.fn.reverse = [].reverse;


function pack_cards(container) {
  var pos = container.offset();
  pos.top += 5;
  pos.left += 5;
    
  $(container).children('img').reverse().each(function(i) {
    $(this).offset(pos).css('z-index', 1000 - i);
  });
}


function spread_cards(container, top, zbonus) {
    var padding =  parseInt($(container).css('padding-left'));
    var top_padding =  parseInt($(container).css('padding-top'));

    $(container).children('img').reverse().each(function(i) {
        position = $(container).offset();
        position.top += top;
        position.left += padding + 100 * i;
        $(this).css('position', 'absolute');
        $(this).offset(position);
        //$(this).css('z-index', $(this).prev().css('z-index') + 1 + zbonus);
    });      
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

  $('#show-graveyard-button').click(function() {
    var box = $('#graveyard');
    var unpacked = (box.parent().get(0).tagName == 'BODY');
    var offset = box.offset();
    var effect = unpacked ? { left: '+=1000', width: '-=1000' } : { left: '-=1000', width: '+=1000' }

    if (!unpacked) {
        $('<div id="placeholder" class="box"></div>').insertBefore(box);
      // box.detach();
      box.appendTo('body');
      box.offset(offset);
      box.animate(effect);
      spread_cards(box, 5, 0);
    } else {
      $('#placeholder').replaceWith(box);
      box.offset(offset);
      box.animate(effect);
      pack_cards(box, 5, 0);
    }

    // $(this).text(hidden ? 'Show' : 'Hide');
  });
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
