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
    this.fixPositions();
  }

  hand.showHand = function(card) {
    if (hand.element.is(':hidden')) {
        hand.toggleShow();
    }
  }

    hand.fixPositions = function() {
      $('#hand').children().each(function(i) {
          position = $('#hand').offset();
          position.top += 20;
          position.left += 20 + 100 * i;
          $(this).css('position', 'absolute');
          $(this).offset(position);
          $(this).css('z-index', $(this).prev().css('z-index') + 1);
      });      
  }

  hand.dropped = function(card, event, ui) {
    card.element.detach();
    this.addCard(card);
  }

});