CARD_W = 120;
CARD_H = 170; 
SPACING = 6;

$.fn.reverse = [].reverse;
controlKeyDown = false;



$(document).ready(function() {

  preventDefaults();

  $('#graveyard, #exile, #library').each(function(i) {
    new Dropbox($(this));
  });

  library = new Library();

  Object.prototype.object = function() {
    return Utils.getObjectFromDom(this);
  }


  $('#battlefield').rightClick(function(event,ui) {
    console.info(event);
    var token = Card.createToken( event.offsetX, event.offsetY);
    token.element.appendTo('#battlefield');
    event.preventDefault();
  });

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

});


function preventDefaults() {
    $('img, #library')
        .click(function(event) { event.preventDefault(); })
        .mousedown(function(event) { event.preventDefault(); });
}
