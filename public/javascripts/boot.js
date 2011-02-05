CARD_W = 120;
CARD_H = 170; 
SPACING = 6;

$.fn.reverse = [].reverse;
controlKeyDown = false;

function run_exclusively(code) {
  if (!mutex) {
    mutex = true;
    code(this);
    mutex = false;
  }
}

function preventDefaults() {
    $('img, .box')
        .click(function(event) { event.preventDefault(); })
        .mousedown(function(event) { event.preventDefault(); });
}


$(document).ready(function() {

  preventDefaults();

  $('#graveyard, #exile, #library').each(function(i) {
    new Dropbox($(this));
  });

  library = new Library();

  Object.prototype.object = function() {
    return Utils.getObjectFromDom(this);
  }

});
