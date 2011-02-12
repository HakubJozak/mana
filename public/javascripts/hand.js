$(document).ready(function() {
  var hand = new Dropbox($($('#hand')[0]));

  hand.element.disableSelection();
  hand.element.droppable( "option", "greedy", true );
  hand.element.draggable();

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
    var h = this.element;
    var count = h.children('.card').length;
    var padding = 10;

    h.css('width', (padding + CARD_W) * count + 2*padding)
    h.children('.card').offset(function(i,coords) {
      return { 
        top: h.offset().top + 30,
        left: padding + h.offset().left + i * (padding + CARD_W),
      }
    });
  }

  hand.add_card = function (card) {
    hand.dropped(card);
  }

  hand.dropped = function(card, event, ui) {
    // replace by super() call
    this.old_drop = Dropbox.prototype.dropped;
    this.old_drop(card, event, ui);
    card.turnOverLocally(false);
  }

});

