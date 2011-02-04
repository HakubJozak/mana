(function($){
  $.fn.reverse = [].reverse;

  $.fn.shuffle = function(selector) {
    var items = $(this).children(selector);
    var max = items.length;
    
    for (var i = 0; i < max; i++) {
      var j = parseInt(Math.random() * i);
      $(items[i]).swap(items[j]);
    }
  }

jQuery.fn.swap = function(b){ 
    b = jQuery(b)[0]; 
    var a = this[0]; 
    var t = a.parentNode.insertBefore(document.createTextNode(''), a); 
    b.parentNode.insertBefore(a, b); 
    t.parentNode.insertBefore(b, t); 
    t.parentNode.removeChild(t); 
    return this; 
};
})(jQuery);

