function Game(url, game_id) {
    this.id_sequence = 0;
    this.url = url;
    this.game_id = game_id;
    this.listener = null;
}

Game.prototype.sendCommand = function(command) {
  this.socket.send(JSON.stringify(command));
}

Game.prototype.create_card = function(image_url) {
  var id = 'custom-card-by-USER_ID-' + this.id_sequence++;
  var card = new Card({  id: id,  image_url: image_url });

  card.turnOverLocally(false);
  $('#hand').object().dropLocally(card);
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


Game.prototype.notifyAll = function(msg) {
 // find a better way of making a command
 if (this.listener != null) {
   this.listener.onRemoteMessage(msg);
 }
}


Game.prototype.setListener = function(l) {
  this.listener = l;
}

Game.prototype.removeListener = function() {
  this.listener = null;
}

Game.prototype.connect = function(username,deck, color) {
  this.socket = new WebSocket(this.url);
  this.socket.game = this;

  this.socket.onerror = function() { game.message('Connection error!'); }
    this.socket.onclose =  function() { game.message('Disconnected.'); }

  this.socket.onopen = function() {
      var g = this.game;
      g.message('Connection opened...');
      g.sendCommand({ action: 'connect', 
                      game_id: g.game_id, 
                      cards: deck,
                      color: color,
                      username: username });
  }

  this.socket.onmessage = function(msg) {

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
};
