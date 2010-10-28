$(document).ready(function() {

  Utils.preventDefaultEvents();

  Card.initialize();
    //game = new Game('ws://connect');
    //game.connect();


      
  // $('img.card').mousewheel(function(event) {
  //     event.preventDefault();
  // });

  $('#graveyard').droppable({
      hoverClass: 'selected',
      drop: function(event,ui) {
          console.log('drop');
      }
  });

  $('#table > *').each(function() {
      $(this).toggleClass('small');
  });

});



