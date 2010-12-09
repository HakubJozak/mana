controlKeyDown = false;

$(document).ready(function() {

  var labels = 'img, #library';

  $(labels).click(function(event) {
    event.preventDefault();
  });

  $(labels).mousedown(function(event) {
    event.preventDefault();
  });

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
    var hidden = box.hasClass('unrolled');
    var effect = hidden ? { left: '+=1000', width: '-=1000' } : { left: '-=1000', width: '+=1000' }

    if (hidden) {
      box.detach();
      $('body').append(box);
    } else {
//      box.detach();
//      $('body').append(box);
    }

    box.animate(effect)
       .css('z-index', 10000)
       .toggleClass('unrolled')
       .toggleClass('droppable');

    spread_cards(box, 5, 0);

    $(this).text(hidden ? 'Show' : 'Hide');
  });
});


