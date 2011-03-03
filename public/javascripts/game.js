function Game(url, game_id) {
    this.id_sequence = 0;
    this.url = url;
    this.game_id = game_id;
    this.listener = null;
}

Game.prototype.sendCommand = function(command) {
  this.socket.send(JSON.stringify(command));
}

// LEGACY - remove
Game.prototype.message = function(msg) {
  InfoView.instance.render(msg)
}


Game.prototype.create_card = function(image_url) {
  var id = User.local().create_unique_id();
  var card = new Card({  id: id,  image_url: image_url });
  var view = new CardView({ model: card });
  $('#battlefield').ob().dropped(view);
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

Game.prototype.connect = function(name,cards, color) {
  this.socket = new WebSocket(this.url);
  this.socket.game = this;

  this.socket.onerror = function() { game.message('Connection error!'); }
  this.socket.onclose = function() { game.message('Disconnected.'); }

  this.socket.onopen = function() {
      var g = this.game;
      g.message('Connection opened...');
      g.sendCommand({ action: 'connect',
                      game_id: g.game_id,
                      cards: cards,
                      color: color,
                      name: name });
  }

  this.socket.onmessage = function(msg) {
    var receive_message = function() {
      var command = JSON.parse(msg.data);

      switch (command.action) {
      case 'Message':
        game.message(command.text);
        break;

      case 'Server':
        command.run = eval(command.action + 'Command').prototype.run;
        command.remote = true;
        command.run();
        break;

      default:
        if (command.card) {
          var card = CardCollection.all.get(command.card.id);
          card.set(command.card);
        } else if (command.message) {
          Chat.instance.add(new Message(command.message))
        }
      }
    }

    if (console.env == 'development') {
      receive_message();
    } else {
      try { receive_message();  } catch (e) { console.error('Mana error:' + e); }
    }
  }
};
