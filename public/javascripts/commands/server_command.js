ServerCommand = function(operation, args) {
  this.action = 'Server';
  this.operation = operation;
  this.args = args;
}

ServerCommand.prototype.run = function() {
  if (this.operation == 'update_library') {
    library.update(this.args.cards);
  }
}
