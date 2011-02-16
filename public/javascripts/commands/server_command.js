ServerCommand = function(operation, args) {
  this.action = 'Server';
  this.operation = operation;
  this.args = args;
}

ServerCommand.prototype.run = function() {
  switch (this.operation) {

  case 'add_user':
    var user = new User(this.args.user);
    var id = user.to_dom_id();
    var template = $('#user-remote-template').html()
      .replace('$USERNAME', user.name)
      .replace(/\$USER_ID/g, id);

    $("#users").append(template);
    var element = $('#' + id);
    element.find('.box').each(function(i) {  new Dropbox($(this));  });
    Utils.setObjectToDom( element, user);

    $(this.args.user.cards).each(function(i,params) {
      card = new Card(params);
      card.turnOverLocally(true);
      card.element.css('position', 'absolute')
      $('#' + id + ' .library').ob().dropLocally(card);
    });

    // $('html > head').append("<link href='/stylesheets/users/" + user.id + ".css' rel='stylesheet' />");

    // if local
    $('#lobby').dialog('close');
    game.message('User ' + user.name + ' connected.');
    break;

  case 'remove_user':
      var user = User.find(this.args.user.id);

      if (true) {
        game.message('User ' + user.name + ' disconnected.');
        $('.' + user.to_dom_id()).fadeOut(function() { $(this).remove(); });
      }
  }
}
