$(document).ready(function() {

  Boot.preventDefaultEvents();
  Boot.specialEffects();

  Card.initialize();
  Dropbox.initialize();

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

Boot.zoomInit = function() {
  $('#battlefield').mousewheel(function(event, delta) {
    //$(this).toggleClass('small');
    console.log(delta);
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