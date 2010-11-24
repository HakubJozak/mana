$(document).ready(function() {
  battlefield = new Dropbox($($('#battlefield')[0]));

  battlefield.tappingAllowed = function() {
    return true;
  }

  battlefield.dropped = function(card,event,ui) {
//    card.moveTo(ui.offset, this.element);
    mc = new MoveCommand(card, this.element.attr('id'));
    mc.run();
    game.sendCommand(mc);
  }

}); 
