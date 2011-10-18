class UserView extends Backbone.View

  @tagName: 'div'
  @className: 'user'

  constructor: (attrs) ->
    super(attrs)
    $('head').append(_.template($('#user-stylesheet-template').html(), @model.toJSON()))

    @components = {}
    @template = _.template($('#user-template').html())
    @el = $(@template(@model.toJSON()))

    @el.droppable
      scope: 'decks'
      tolerance: 'touch'
      hoverClass: 'deck-over'
      drop: @deck_dropped


    _.each [ 'library', 'graveyard', 'exile' ], (collection) =>
      @components[collection] = new Dropbox({ model: @model[collection] })
      @el.append(@components[collection].el)

    @model.bind 'change', @render
    @model.hand.bind 'add', @render
    @model.hand.bind 'remove', @render

    root = if @model.local then 'left' else 'right'
    $("##{root}-panel .users").append(@el)
    @render()

  deck_dropped: (event, ui) =>
    deck = ui.draggable.ob()

#    if confirm("Do you really want to show cards in your #{deck.name} to #{@model.name()}")
    Action.show_deck(deck, @model).save()

  render: =>
    @$('.lives').val(@model.lives())
    @$('.hand-size').text('(' + @model.hand.size() + ')')


window.UserView = UserView