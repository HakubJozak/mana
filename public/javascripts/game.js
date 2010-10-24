function Game(url, infobox) {
    this.url = url;
    this.connected = false;
    this.infobox = $('#infobox');
}

Game.prototype.connect = function() {
  this.socket = new WebSocket(this.url);
  
  this.socket.onopen = function() {
    this.message('Online');
    this.connected = true;
  }

  this.socket.onmessage = function(e) {
    // TODO: accept commands and messages
  };

  this.socket.onerror = function() {
    this.message('Error!');
  };
  
  this.socket.onclose = function() {
    this.message('Disconnected');
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

Game.prototype.message = function(msg) {
    this.infobox.replaceWith('<div id="infobox">' + msg + '</div>');
}





