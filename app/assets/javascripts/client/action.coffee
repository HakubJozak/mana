class Action extends Backbone.Model

  @show_deck = (collection, user) ->
    new Action(type: 'show_collection', collection_id: collection.id, user_to_id: user.id )

  initialize: =>
    @set clazz: 'Action'
    @type = @get 'type'

  run: =>
    if @type == 'show_collection' and User.local? and User.local.id == @get('user_to_id')
      collection = CardCollection.all[@get('collection_id')]
      new HandView(model: collection)


window.Action = Action