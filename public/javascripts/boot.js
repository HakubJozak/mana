controlKeyDown = false;

$(document).ready(function() {

  Boot.preventDefaultEvents();

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

//  $( "#users" ).accordion({
//    icons: ''
//  });
  // $('img.card').mousewheel(function(event) {
  //     event.preventDefault();
  // });
});

Boot = function() {};

Boot.preventDefaultEvents = function() {
    var labels = 'img, #library';

    $(labels).click(function(event) {
        event.preventDefault();
    });

    $(labels).mousedown(function(event) {
        event.preventDefault();
    });
}
