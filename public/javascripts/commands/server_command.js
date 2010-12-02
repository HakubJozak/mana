ServerCommand = function(operation, args) {
  this.action = 'Server';
  this.operation = operation;
  this.args = args;
}

ServerCommand.prototype.run = function() {
  switch (this.operation) {
  case 'update_library': 
    library.update(this.args.cards);
    break;

  case 'add_user':
    this.user;
    break;
  }
  if (this.operation == 'update_library') {
    ;
  }
}
