class UserView extends Backbone.View

  @tagName: 'div'
  @className: 'user'

  constructor: (attrs) ->
    super(attrs)
    $('head').append(_.template($('#user-stylesheet-template').html(), @model.toJSON()))

    @components = {}
    @template = _.template($('#user-template').html())
    @el = $(@template(@model.toJSON()))

    _.each [ 'library', 'graveyard', 'exile' ], (collection) =>
      @components[collection] = new Dropbox({ model: @model[collection] })
      @el.append(@components[collection].el)

    @components['hand'] = new HandView({ model: @model.hand });
    @model.bind 'change', @render

    root = if @model.local then 'left' else 'right'
    $("##{root}-panel .users").append(@el)

  render: =>
    @$('.lives').val(@model.lives())


window.UserView = UserView