$(document).ready(function() {
  var hand = new Dropbox($($('#hand')[0]));

  hand.element.disableSelection();
  hand.element.droppable( "option", "greedy", true );

  hand.element.draggable({ 
  //  axis: 'y',
  //  containment: '#battlefield'
  });


  $('#battlefield').click(function(event) {
      $('#hand').object().toggleShow(event);
      event.stopPropagation();
  });

  hand.toggleShow = function() {
    h = this.element;

    if (h.is(':visible')) {
      h.fadeOut(400, 'swing', function() {
        $(this).detach().appendTo('#coffin');
      });
    } else {
      h.detach().appendTo('#battlefield');
      h.fadeIn(400, 'swing');
    }
  }

  hand.showHand = function(card) {
    if (hand.element.is(':hidden')) {
        hand.toggleShow();
    }
  }

  hand.fixPosition = function() {
    var count = this.element.children('img').length
    this.element.css('width', (SPACING + CARD_W) * count + 2*SPACING)
    spread_cards('#hand', 25);
  }

  hand.dropped = function(card, event, ui) {
    // replace by super() call
    this.old_drop = Dropbox.prototype.dropped;
    this.old_drop(card, event, ui);
    console.info('sss')
    card.turnOverLocally(false);
  }

});

