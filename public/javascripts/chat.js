$(document).ready(function() {
  $('#chat-bar')
    .draggable()
    .keyup(close_or_submit)
    .children('input').blur();
});

function close_or_submit(event) {
    switch (event.keyCode) {
     case 27:
        close_chat();
        break;

     case 13:
        submit_chat();
        close_chat();
        break;
    }
  
}

function close_chat() {
  $('#chat-bar').hide().children('input').blur();
}

function submit_chat() {
  var input = $('#chat-bar input');
  MessageCommand.createAndRun(User.local().name + ': ' + input.val());
  input.val('');
  return false;
}
