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

    _.each [ 'library', 'graveyard'], (collection) =>
      @components[collection] = new Dropbox({ model: @model[collection] })
      @el.append(@components[collection].el)

    @model.bind 'change', @render
    @model.hand.bind 'add', @render
    @model.hand.bind 'remove', @render

    root = if @model.local then 'left' else 'right'
    $("##{root}-panel .users").append(@el)

    @$('form').submit @lives_changed
    @$('.plus').click => @change_lives(1)
    @$('.minus').click => @change_lives(-1)
    @render()

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
    @model.set(lives: lives, { silent: true })
    @model.save()
    Message.action "is changing #{@model.name()}'s live count to #{lives}."
    return false

  render: =>
    @$('.lives').val(@model.lives())
    @$('.hand-size').val(@model.hand.size())


window.UserView = UserView
