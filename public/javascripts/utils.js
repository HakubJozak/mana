Utils = function() {}

function _(method) {
    return function(event) {
        return eval("$(this).data('game-object')." + method + '(event)');
    }
}


Utils.setObjectToDom = function(element, data) {
    $(element).data('game-object', data);
    return data;
}

Utils.getObjectFromDom = function(element) {
    return $(element).data('game-object');
}


