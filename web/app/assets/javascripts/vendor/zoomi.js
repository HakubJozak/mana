// zoomi - A zoom for images ~ Sean Catchpole - Version 0.9
(function($){

$.fn.zoomi = function() {
  $(this).filter("img").each(function(){
    if(!this.z) {
      $(this).zoom1().mouseover(function(){$(this).zoom2().show();});
      $(this.z).mouseout(function(){$(this).hide();}); }
  });
 return this;
}

$.fn.zoom1 = function() {
  $(this).each(function(){
    var e = this;
    $(e).css({'position':'relative','z-index':'8'}).after('<img class="'+e.className+'">');
    e.z = e.nextSibling;
    $(e.z).removeClass("zoomi").addClass("zoom2").attr("src",e.alt || e.src)
    .css({'position':'absolute','z-index':'10'});
    $(e.z).hide();
  });
  return this;
}

$.fn.zoom2 = function() {
  var s = [];
  this.each(function(){
    var e = this;
    if(!e.z) e = $(e).zoom1()[0]; s.push(e.z);
    if(!e.z.complete) return;
    if(!e.z.width) { $(e.z).show(); e.z.width=e.z.width; $(e.z).hide(); }
    $(e.z).css({left:$(e).offsetLeft()-(e.z.width-e.scrollWidth)/2+'px',
    top:$(e).offsetTop()-(e.z.height-e.scrollHeight)/2+'px'});
  });
  return this.pushStack(s);
}

$.fn.offsetLeft = function() {
  var e = this[0];
  if(!e.offsetParent) return e.offsetLeft;
  return e.offsetLeft + $(e.offsetParent).offsetLeft(); }

$.fn.offsetTop = function() {
  var e = this[0];
  if(!e.offsetParent) return e.offsetTop;
  return e.offsetTop + $(e.offsetParent).offsetTop(); }

$(function(){ $('img.zoomi').zoomi(); });

})(jQuery);
