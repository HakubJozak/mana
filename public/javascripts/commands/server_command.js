ServerCommand = function(operation, args) {
  this.action = 'Server';
  this.operation = 'update';
  this.arguments = args;
}

ServerCommand.prototype.run = function() {
}
