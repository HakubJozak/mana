function closeLobby() {
  $('#lobby').dialog('close');
}

function lobby_input(name) {
  return $('#lobby form *[name="' + name + '"]').val();
}

function lobby_submit() {
  var lobby = {
    onRemoteMessage: function(data) {
      game.message('You joined the game.');
      game.removeListener();
      closeLobby();
    } 
  };
      
  game.setListener(lobby);
  game.connect( lobby_input('name'), lobby_input('cards'));
  return false;
}

$(document).ready(function() {
  var form = $('#lobby form');

  form.submit(lobby_submit);

  $("#lobby").dialog({
    autoOpen: true,
    width: 400,
    modal: true,

    open: function(event, ui) { 
      //hide close button.
      $(this).parent().find('.ui-dialog-titlebar-close').hide();
    },

    buttons: [ 
        { text: 'Play', click: function() { return lobby_submit(); } },
   ]
  });
});