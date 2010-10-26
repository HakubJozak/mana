function preventAll() {
  labels = [ 'img', '#deck' ];

  for (i in labels) {
    $(labels[i]).click(function(event) {
      event.preventDefault();
    });

    $(labels[i]).mousedown(function(event) {
      event.preventDefault();
    });
  }
}


$(document).ready(function() {

    //game = new Game('ws://connect');
    //game.connect();

  preventAll();
      
  // $('img.card').mousewheel(function(event) {
  //     event.preventDefault();
  // });

  $('#graveyard').droppable({
      hoverClass: 'selected',
      drop: function(event,ui) {
          console.log('drop');
      }
  });

  $('.card').each(function(i) {
    img = $(this);
      // img.data('card-id');
      img.draggable( { snap: true, snapMode: 'inner' } );
      img.draggable( "option", "zIndex", 2700 );
      //img.toggleClass('small', 500);

      img.dblclick(function () {
        $(this).toggleClass('tapped');
      });

      // img.mousewheel(function(event, delta) {
      //   //$(this).toggleClass('small');
      //   console.log(delta);
      // });
  });
});