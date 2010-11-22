var game;

$(document).ready(function() {

  Boot.preventDefaultEvents();

  Dropbox.initialize();

  Object.prototype.object = function() {
    return Utils.getObjectFromDom(this);
  }

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
