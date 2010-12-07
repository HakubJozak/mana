function Game(url, game_id) {
    this.url = url;
    this.game_id = game_id;
    this.listener = null;
}

Game.prototype.onmessage = function(msg) {
  console.info(msg);

  try {  
   var command = JSON.parse(msg.data);
   this.game.notifyAll(command);
   command.run = eval(command.action + 'Command').prototype.run;
   command.remote = true;
   command.run();
  } catch (e) {
    console.error('Mana Error:' + e);
    this.game.message('Error:' + e);
  }
}

Game.prototype.onerror = function() {
  this.game.message('Connection error!');
}

Game.prototype.notifyAll = function(msg) {
 // find a better way of making a command
 if (this.listener != null) {
   this.listener.onRemoteMessage(msg);
 }
}

Game.prototype.onclose = function() {
  this.game.message('Disconnected.');
}

Game.prototype.setListener = function(l) {
  this.listener = l;
}

Game.prototype.removeListener = function() {
  this.listener = null;
}

Game.prototype.connect = function(username,deck) {
  this.socket = new WebSocket(this.url);
  this.socket.game = this;
  this.socket.onmessage = this.onmessage;
  this.socket.onerror = this.onerror;
  this.socket.onclose = this.onclose;
  this.socket.onopen = function() {
      var g = this.game;
      g.message('Connection opened...');
      g.sendCommand({ action: 'connect', 
                      game_id: g.game_id, 
                      cards: deck, 
                      username: username });
  }

};


Game.prototype.sendCommand = function(command) {
  this.socket.send(JSON.stringify(command));
}



Game.prototype.message = function(msg) {
  var box = $('#infobox');
  var output = $('#infobox p:first');

  output.append(msg + "<br/>");

  if (!box.is(':visible')) {
    box.show('fade').delay(5000).hide('fade', function() {
        $('#infobox p:first').html('');
    });
  }
}


Game.user_dom_id = function(user) {
  return 'user-' + user.id;
}