ServerCommand = function(operation, args) {
  this.action = 'Server';
  this.operation = operation;
  this.args = args;
}

ServerCommand.prototype.run = function() {
  switch (this.operation) {

  case 'update_library':
    library.update(this.args.cards);
    break;

  case 'add_user':
    var id = Game.user_dom_id(this.user);
    var template = $('#user-remote-template').html().replace('$USERNAME', this.user.name);
    var user = new User(this.user.name, '#ffffff')

    game.message('User ' + this.user.name + ' connected.');
    user_html = $('<div id="' + id + '" class="' + id +'">' + template + '</div>');
    Utils.setObjectToDom( user_html, user);
    $("#users").append(user_html);

    break;

  case 'remove_user':
    game.message('User ' + this.user.name + ' disconnected.');
      console.info(this.user)
    $('.' + Game.user_dom_id(this.user)).fadeOut(function() {
      $(this).remove();
    });
  }
}


