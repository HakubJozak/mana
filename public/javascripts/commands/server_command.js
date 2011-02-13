ServerCommand = function(operation, args) {
  this.action = 'Server';
  this.operation = operation;
  this.args = args;
}

ServerCommand.prototype.run = function() {
  switch (this.operation) {

  case 'start_game':
    var user = this.args.user;
    library.update(user.cards);

    $('#user-local h3').text(user.name);
    Utils.setObjectToDom('#user-local', new User(user));
    game.message('You joined the game as ' + user.name + '.');
    break;

  case 'add_user':
    var user = new User(this.user);
    var id = user.to_dom_id();
    var template = $('#user-remote-template').html().replace('$USERNAME', user.name);

    game.message('User ' + user.name + ' connected.');
    user_html = $('<div id="' + id + '" class="' + id +'">' + template + '</div>');
    Utils.setObjectToDom( user_html, user);
    $('html > head').append("<link href='/stylesheets/users/" + user.id + ".css' rel='stylesheet' />");
    $("#users").append(user_html);

    break;

  case 'remove_user':
    var user = User.find(this.user.id)
    game.message('User ' + this.user.name + ' disconnected.');
    $('.' + user.to_dom_id).fadeOut(function() {
      $(this).remove();
    });
  }
}


function add_user() {
}