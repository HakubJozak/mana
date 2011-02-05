$(document).ready(function() {
  battlefield = $('#battlefield');

  Utils.setObjectToDom( battlefield, {
    tappingAllowed: function() { return true; },
    fixPosition: function() {},
    dropped: Dropbox.prototype.dropped
  });

  battlefield.droppable({
    scope: 'cards',
    greedy: false,
    hoverClass: 'card-over',
    
    // HACK - otherwise battlefield eats all the events
    accept: function(draggable) {
      return ($('.card-over' ).length < 2) && draggable.hasClass('card');
    },

    drop: function(event,ui) {
      card = ui.draggable.object();
      this.object().dropped(card,event,ui);
    }
  });
});
