$(document).ready(function() {
  battlefield = new Dropbox($($('#battlefield')[0]));

  battlefield.tappingAllowed = function() {
    return true;
  }

  battlefield.dropped = function(card,event,ui) {
    c = card.element;
    c.detach();
    c.appendTo(this.element);
    c.offset( ui.offset );
    game.moved(card);
  }


}); 
