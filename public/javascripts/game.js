function Game(url, game_id) {
    this.url = url;
    this.game_id = game_id;
}

Game.prototype.onopen = function() {
  var g = this.game;
  g.message('Connection opened...');
  g.sendCommand({ action: 'Connect', game_id: g.game_id });
}

Game.prototype.onmessage = function(msg) {
  console.info(msg);

  try {  
   var command = JSON.parse(msg.data);
   // find a better way of making a command
   command.run = eval(command.action + 'Command').prototype.run;
   command.run();
  } catch (e) {
    console.error(e);
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
  var box = $('#infobox');
  $('#infobox label:first').text(msg);


  if (!box.is(':visible')) {
    box.show('fade').delay(5000).hide('fade');
  }
}
