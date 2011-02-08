//
// BUTTONS
//
$(document).ready(function() {
  bind_control('.uncover-button',function(box) { box.coverAll(false); });
  bind_control('.cover-button',function(box) { box.coverAll(true); });
  bind_control('.shuffle-button',function(box) { box.shuffle(); });
  bind_control('.close-button',function(box) { box.pack_unpack(this); });


  $('.browse-button').click(function() { 
    // TODO: can be done smarter - check again when online
      $(this).parent().next().object().pack_unpack();
   });

  $('#battlefield').click(function(event) {
      $('#hand').object().toggleShow(event);
      event.stopPropagation();
  });
});



//
// KEYS
//
$(document).keypress(function(e) {

  // ignore keypresses on valid inputs
  if ($(e.target)[0].nodeName == 'INPUT')
    return;

  switch (String.fromCharCode(e.keyCode)) {
  case 't':
    cards = $('.card:hover');
    if (cards.length > 0) cards.object().turnOver();
    break;

  case 'm':
    $('#chat-bar').toggle()
    $('#chat-bar input').focus();
    break;

  case ' ':
    $('#hand').object().toggleShow();
    break;
  }

  e.stopPropagation();
  e.preventDefault();

});


//
// HELPERS
//
function bind_control(name, action) {
 $(name).click(function(event) {
    action($(this).closest('.box').object());
    event.preventDefault();
    event.stopPropagation();
  });
}