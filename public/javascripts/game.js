function Game(url) {
  this.url = url;
  this.connected = false;
}

Game.prototype.connect = function() {
  this.socket = new WebSocket(this.url);
  
  this.socket.onopen = function() {
    alert('connected');
    this.connected = true;
  }

  this.socket.onmessage = function(e) {
    // TODO: accept commands and messages
  };

  this.socket.onerror = function() {
      alert('pruser');
  };
  
  this.socket.onclose = function() {
    this.connected = false;
  };
};


Game.prototype.move_card = function(card,x,y) {
  this.socket.send({
    'command' : 'MOVE',
    'card' : card,
    'x' : x,
    'y' : y
  });
};

Game.prototype.tap = function(card) {
  this.socket.send({
    'command' : 'TAP',
    'card' : card
  });
};





