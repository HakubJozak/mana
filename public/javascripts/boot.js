$(document).ready(function() {

  Boot.preventDefaultEvents();
  Boot.specialEffects();

  Card.initialize();
  Dropbox.initialize();

  Object.prototype.object = function() {
    return Utils.getObjectFromDom(this);
  }

  $('#hand').disableSelection();

    //game = new Game('ws://connect');
    //game.connect();
      
  // $('img.card').mousewheel(function(event) {
  //     event.preventDefault();
  // });

});

Boot = function() {};

Boot.preventDefaultEvents = function() {

    labels = 'img, #deck';

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