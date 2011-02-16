//
// BUTTONS
//
$(document).ready(function() {
  bind_control('.uncover-button',function(box) { box.coverAll(false); });
  bind_control('.cover-button',function(box) { box.coverAll(true); });
  bind_control('.shuffle-button',function(box) { box.shuffle(); });
  bind_control('.close-button',function(box) { box.pack_unpack(this); });

 $('.browse-button').live('click',function() { 
     // TODO: can be done smarter - check again when online
     $(this).parent().next().ob().pack_unpack();
     return false;
  });

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
      var cards = $('.card:hover');
      if (cards.length > 0) cards.ob().turnOver();
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



//
// HELPERS
//
function bind_control(name, action) {
 $(name).live('click',function(event) {
    action($(this).closest('.box').ob());
    event.preventDefault();
    event.stopPropagation();
  });
}

function adjust_card(property,e) {
  var cards = $('.card:hover');

      if (cards.length > 0) {
        console.info(e);
        cards.ob().adjust({ 
            property: property,
            minus: e.shiftKey, 
            clear: e.ctrlKey
          });
      }

}

