Utils = function() {}

function _(method) {
    return function() {
        return eval("$(this).data('game-object')." + method + '()');
    }
}

Utils.setObjectToDom = function(element, data) {
    $(element).data('game-object', data);
    return data;
}

// Utils.getObjectFromDom = function(element) {
//     return $(element).data('game-object');
// }


Utils.preventDefaultEvents = function() {

    labels = 'img, #deck';

    $(labels).click(function(event) {
        event.preventDefault();
    });

    $(labels).mousedown(function(event) {
        event.preventDefault();
    });
}
