Utils = function() {}
window.Utils = Utils;

function switch_parent(box, parent, prepend) {
  var old = box.offset();
  box.detach();
  box.prependTo(parent);
  box.offset(old);
}


Utils.setObjectToDom = function(element, data) {
  $(element).data('game-object', data);
  data.element = element;
  return data;
}

Utils.getObjectFromDom = function(element) {
    return $(element).data('game-object');
}

Utils.camelize = function(string){
  return jQuery.camelCase(string).replace(/^\w/, function($1){return $1.toUpperCase()});
}