$(document).ready(function() {

    //game = new Game('ws://connect');
    //game.connect();
      


  // $('img').click(function(event) {
  //     event.preventDefault();
  // });

  $('img.card').mousedown(function(event) {
      event.preventDefault();
  });

  $(".card").tooltip({ 
      delay: 1000,
      showURL: false,
      bodyHandler: function() { 
          image = $("<img/>").attr("src", this.src)
          return image; 
      }, 
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