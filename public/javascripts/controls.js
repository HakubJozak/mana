//
// BUTTONS
//
$(document).ready(function() {


  $('#battlefield').click(function(event) {
      $('#hand').ob().toggleShow(event);
      event.stopPropagation();
  });


  //
  // KEYS
  //
  $(document).keypress(function(e) {
    // ignore keypresses on valid inputs
    var name = $(e.target)[0].nodeName;

    if (name == 'INPUT' || name == 'TEXTAREA')
      return;

    switch (String.fromCharCode(e.keyCode)) {

    // TODO: DRY
    case 'u':
      break;

    case 'C':
    case 'c':
      adjust_card('counters',e);
      break;

    case 'T':
    case 't':
      adjust_card('toughness',e);
      break;

    case 'P':
    case 'p':
      adjust_card('power',e);
      break;

    case 'a':
      $('#create-card-dialog').dialog('open');
      break;

    case 'm':
      $('#chat-bar').toggle()
      $('#chat-bar input').focus();
      break;

    case 'h':
      $('#help').toggle();
      break;

    case ' ':
      $('#hand').ob().toggleShow();
      break;
    }

    e.stopPropagation();
    e.preventDefault();
  });
});




function adjust_card(property,e) {
  var cards = $('.card:hover');

  if (cards.length > 0) {
     cards.ob().adjust({
     property: property,
     minus: e.shiftKey,
     clear: e.ctrlKey
   });
  }
}

