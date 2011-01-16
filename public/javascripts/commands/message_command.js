MessageCommand = function(text) {
  this.action = 'Message';
  this.text = text;
}

MessageCommand.prototype.run = function() {
  game.message(this.text);
}

MessageCommand.createAndRun = function(msg) {
  cmd = MessageCommand.new(msg);
  cmd.run();
  game.send(cmd);
}
