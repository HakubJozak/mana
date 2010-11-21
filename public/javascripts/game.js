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
   var command = JSON.parse(msg.data);
   // find a better way of making a command
   command.run = eval(command.action + 'Command').prototype.run;
   command.run();
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


Game.prototype.sendCommand = function(command) {
  this.socket.send(JSON.stringify(command));
}

Game.prototype.message = function(msg) {
  this.infobox.text(msg);
}
