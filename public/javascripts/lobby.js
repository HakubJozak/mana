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
      onRemoteMessage: function(command) {
        if (command.operation == 'update_library') {
          name = lobby_input('name');
          
          // TODO: move somewhere else / rewrite
          $('#user-local h3').text(name);
          game.user = { name: name, color: '#ff0000' };
         
          game.message('You joined the game as ' + name + '.');
          game.removeListener();
          closeLobby();
          $('button').attr('disabled',false);
        } else if (command.operation == 'progress') {
          $( "#lobby-progress-message" ).text(command.card);
          $( "#lobby-progress-bar" ).progressbar( "option", "value", command.value );
        }
      }
    };
    
    $('button').attr('disabled',true);
    $( "#lobby-progress-message" ).text('Loading cards, please wait...');
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
      $("#lobby-progress-bar").progressbar();
    },

    buttons: [ 
        { text: 'Play', click: function() { return lobby_submit(); } },
   ]
  });
});