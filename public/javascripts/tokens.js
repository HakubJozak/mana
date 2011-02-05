Card.createToken = function(x,y) {
  var token = new Card({
      name: 'Token',
     id: 'token-' + 'USER_ID' + '-',
     picture: '/images/token.jpg'
  });

    token.element.offset({ top: x, left: y });
  return token;
}
