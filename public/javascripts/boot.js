$(document).ready(function() {

  Utils.preventDefaultEvents();

  Card.initialize();
  Dropbox.initialize();
    //game = new Game('ws://connect');
    //game.connect();
      
  // $('img.card').mousewheel(function(event) {
  //     event.preventDefault();
  // });


  $('#table > *').each(function() {
      $(this).toggleClass('small');
  });

});



