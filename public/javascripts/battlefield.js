$(document).ready(function() {
  battlefield = new Dropbox($($('#battlefield')[0]));
  battlefield.tappingAllowed = function() { return true; }
  battlefield.fixPosition = function() {}

  // HACK - otherwise battlefield eats all the events
  battlefield.element.droppable( "option", "accept", function(draggable) {
    return ($('.unpacked' ).length == 0) && draggable.hasClass('card');
  } );

}); 
