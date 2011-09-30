CARD_W = 120;
CARD_H = 170; 
SPACING = 6;

$.fn.reverse = [].reverse;


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

  // $(window).bind('beforeunload',function(e) {
  //   if (!confirm('Are you sure to leave the game?')) {
  //     e.preventDefaults();
  //     return false;
  //   }
  // });

  jQuery.fn.ob = function() {
    return Utils.getObjectFromDom(this);
  }

});



