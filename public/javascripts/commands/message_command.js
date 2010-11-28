MessageCommand = function(text) {
  this.action = 'Message';
  this.text = text;
}

MessageCommand.prototype.run = function() {
  game.message(this.text);
}
