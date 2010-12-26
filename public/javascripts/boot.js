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
   pack_unpack('graveyard','graveyard-placeholder');
 });

 $('#show-exile-button').click(function() {
   pack_unpack('exile','exile-placeholder');
 });

 $('#show-library-button').click(function() {
   pack_unpack('library','library-placeholder', true);
 });

  $('#shuffle-button').click(function(event) {
          // pack_cards($('#library'));
     $('#library').shuffle();
     MessageCommand.createAndRun('Library shuffled');
     event.preventDefault();
  });
});


function preventDefaults() {
    $('img, #library')
        .click(function(event) { event.preventDefault(); })
        .mousedown(function(event) { event.preventDefault(); });
}
