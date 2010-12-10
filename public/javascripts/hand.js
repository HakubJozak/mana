$(document).ready(function() {
  var hand = new Dropbox($($('#hand')[0]));

  hand.element.disableSelection();
  hand.element.droppable( "option", "greedy", true );

  hand.element.draggable({ axis: 'y',
                           containment: '#battlefield'
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

  hand.addCard = function(card) {
    card.element.appendTo(this.element);
    this.fixPosition();
  }

  hand.showHand = function(card) {
    if (hand.element.is(':hidden')) {
        hand.toggleShow();
    }
  }

  hand.fixPosition = function() {
      spread_cards('#hand', 25, 0);
  }
/*
  hand.dropped = function(card, event, ui) {
    card.element.detach();
    this.addCard(card);
  }
    */
});

