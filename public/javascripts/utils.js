Utils = function() {}

function _(method) {
    return function(event) {
        return eval("$(this).data('game-object')." + method + '(event)');
    }
}

function switch_parent(box, parent) {
  var old = box.offset();
  box.detach();
  box.appendTo(parent);
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


