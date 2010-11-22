var game;

$(document).ready(function() {

  Boot.preventDefaultEvents();
  Boot.specialEffects();

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


Boot.specialEffects = function() {

  $('#graveyard, #deck, #exile, .card').each(function() {
      $(this).addClass('rounded-borders');
      $(this).addClass('card-size');
    })

  $('.area').each(function() {
    $(this).addClass('rounded-borders');
  });

}