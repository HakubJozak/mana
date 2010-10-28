Card = function(image) {
    this.img = image;
    this.picture = image.attr('src');
    console.log(this.picture);
    this.initDOM();
}

Card.prototype.tap = function() {
    this.img.toggleClass('tapped');
}

Card.prototype.turn = function() {
    
    if (this.isCovered()) {
        this.img.removeClass('covered')
                .attr('src', this.picture);
    } else {
        this.img.addClass('covered')
                .attr('src', "/images/back-side.jpg");
    }
}

Card.prototype.isCovered = function() {
    return this.img.hasClass('covered');
}


Card.prototype.initDOM = function() {
    Utils.setObjectToDom(this.img, this);

    this.img.draggable( { 
        snap: true, 
        snapMode: 'inner',
        stack: '#table > *',
        zIndex: 9999
    });

    this.img.click(_('tap'));
    this.img.rightClick(_('turn'));

    // img.mousewheel(function(event, delta) {
    //   //$(this).toggleClass('small');
    //   console.log(delta);
    // });
}



Card.initialize = function() {
    $('.card').each(function(i) {
        card = new Card($(this));
    });
}

