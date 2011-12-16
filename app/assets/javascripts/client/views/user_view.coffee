class UserView extends Backbone.View

  @tagName: 'div'
  @className: 'user'

  constructor: (attrs) ->
    super(attrs)
    $('head').append(_.template($('#user-stylesheet-template').html(), @model.toJSON()))

    @components = {}
    @template = _.template($('#user-template').html())
    @el = $(@template(@model.toJSON()))

    # TODO: call from elsewhere
    BattlefieldView.instance.create_user_part(@model)

    @el.droppable
      scope: 'decks'
      tolerance: 'touch'
      hoverClass: 'deck-over'
      drop: @deck_dropped

    @model.bind 'change', @render
    @model.hand.bind 'add', @render
    @model.hand.bind 'remove', @render

    if @model.local
      @$('form').submit @lives_changed
      @$('.plus').click => @change_lives(1)
      @$('.minus').click => @change_lives(-1)
    else
      @$('.plus').hide()
      @$('.minus').hide()

    @components.library = new Dropbox(model: @model.library, shuffle: @model.local)
    @components.graveyard = new Dropbox(model: @model.graveyard, shuffle: @model.local )

    @el.append(@components.library.el)
    @el.append(@components.graveyard.el)

  deck_dropped: (event, ui) =>
    deck = ui.draggable.ob()

    if User.local != @model and confirm("Do you really want to show cards in your #{deck.name} to #{@model.name()}")
      Action.show_deck(deck, @model).save()

  change_lives: (delta) =>
    lives = @$('input.lives').val()
    @$('input.lives').val(parseInt(lives) + delta)
    @$('form').submit()

  lives_changed: =>
    lives = parseInt(@$('input.lives').val())
    @model.set(lives: lives)
    @model.save()
    return false

  render: =>
    @$('.lives').val(@model.lives())
    @$('.hand-size').val(@model.hand.size())


window.UserView = UserView
