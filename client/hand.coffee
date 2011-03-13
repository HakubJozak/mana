class Hand extends CardCollection

  constructor: (attrs) ->
    throw 'Hand must have an owner - "user" not specified' unless attrs.user
    @user = attrs.user
    super(@user.id, 'Hand')
