$(document).ready(function() {
  battlefield = new Dropbox($($('#battlefield')[0]));

  battlefield.tappingAllowed = function() { return true; }
  battlefield.fixPosition = function() {}
}); 
