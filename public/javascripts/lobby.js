function closeLobby() {
  $('#lobby').dialog('close');
}

function lobby_input(name) {
  return $('#lobby form *[name="' + name + '"]').val();
}

function lobby_submit() {
    cmd = new ServerCommand('update_library', { cards: lobby_input('cards') })
    game.sendCommand(cmd);
    // $('#lobby-message p strong').text('JO!');
    // $('#lobby-message').fadeIn();
    closeLobby();
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