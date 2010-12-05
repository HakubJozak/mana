function closeLobby() {
  $('#lobby').dialog('close');
}

function lobby_input(name) {
  return $('#lobby form *[name="' + name + '"]').val();
}

function lobby_valid() {
  if (lobby_input('name') == '') {
    game.message('Please enter your name.');
    return false;
  }


  return true;
}


function lobby_submit() {
  if (lobby_valid()) {
    var lobby = {
      onRemoteMessage: function(data) {
        name = lobby_input('name');
        game.message('You joined the game as ' + name + '.');
        $('#user-local h3').text(name);
        game.removeListener();
        closeLobby();
        $('button').attr('disabled',false);
      }
    };
    
    $('button').attr('disabled',true);
    game.setListener(lobby);
    game.connect( lobby_input('name'), lobby_input('cards'));
  }

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