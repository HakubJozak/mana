$(document).ready(function() {

    game = new Game();
    game.connect();
      


  // $('img').click(function(event) {
  //     event.preventDefault();
  // });

  $('img.card').mousedown(function(event) {
      event.preventDefault();
  });


  $('.card').each(function(i) {
    img = $(this);
    // img.data('card-id');
      img.draggable( { snap: true, snapMode: 'inner' } );
      img.toggleClass('small', 500);

      img.dblclick(function () {
          $(this).toggleClass('tapped');
      });
  });
});