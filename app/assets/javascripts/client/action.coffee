class Action extends Backbone.Model

  @show_deck = (collection, user) ->
    new Action(type: 'show_collection', collection_id: collection.id, user_to_id: user.id )

  @create_token = (card_stamp_id) ->
    new Action(type: 'create_token', card_stamp_id: card_stamp_id, player_id: User.local.id )

  initialize: =>
    @set clazz: 'Action'
    @type = @get 'type'

  run: =>
    if @type == 'show_collection'
      if User.local? and User.local.id == @get('user_to_id')
        collection = CardCollection.all[@get('collection_id')]

        if collection.name == 'hand'
          new HandView(model: collection)
        else
          new CardBrowser(model: collection)

window.Action = Action