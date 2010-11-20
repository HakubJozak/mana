function Game(url) {
    this.url = url;
    this.connected = false;
    this.infobox = $('#infobox label:first');
}

Game.prototype.onopen = function() {
  this.game.message('Connected!');
}

Game.prototype.onmessage = function(msg) {
  console.info(msg);

    try {  
      command = JSON.parse(msg.data);

  switch (command.action) {
    case 'TAP':
      this.game.message('Player X tapped ' + command.card_id + command.state);
      Card.find(command.card_id).tap(command.state);
      break;
  
    case 'MESSAGE':
      this.game.message(command.text);
      break;
    }
  } catch (e) {
     console.info(e);
     this.game.message('Error:' + e);
  }
}

Game.prototype.onerror = function() {
  alert('Error!');
}

Game.prototype.onclose = function() {
  this.game.message('Connection closed.');
}

Game.prototype.connect = function() {
  this.socket = new WebSocket(this.url);
  this.socket.onopen = this.onopen;
  this.socket.onmessage = this.onmessage;
  this.socket.onerror = this.onerror;
  this.socket.onclose = this.onclose;
  this.socket.game = this;
};

Game.prototype.tapped = function(card,state) {
  command = { 
      action : 'TAP', 
      card_id : card.id,
      state: state
  };

  this.socket.send(JSON.stringify(command));
};



/*
Game.prototype.move_card = function(card,x,y) {
  this.socket.send({
    'command' : 'MOVE',
    'card' : card,
    'x' : x,
    'y' : y
  });
};
*/


Game.prototype.message = function(msg) {
  this.infobox.text(msg);
}
