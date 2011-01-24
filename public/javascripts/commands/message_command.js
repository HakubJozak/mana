MessageCommand = function(text) {
  this.action = 'Message';
  this.text = text;
}

MessageCommand.prototype.run = function() {
  game.message(this.text);
}

MessageCommand.createAndRun = function(msg) {
  cmd = new MessageCommand(msg);
  cmd.run();
  game.sendCommand(cmd);
}
