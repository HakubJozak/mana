$(document).ready(function() {
  var hand = new Dropbox($($('#hand')[0]));
  hand.element.droppable( "option", "greedy", true );

  $('#hand-toggle').click(function() {
    $('#hand').fadeToggle();
  });

  hand.addCard = function(card) {
    card.element.appendTo(this.element);
    this.fixPositions();
  }

  hand.showHand = function(card) {
    hand.element.fadeIn();
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
  }});