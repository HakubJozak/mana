class UserView extends Backbone.View

  @tagName: 'div'
  @className: 'user'

  constructor: ->
    super
    @model.bind 'change', @render
    @components = {}
    @template = _.template($('#user-template').html())
    @el = $(@template(@model.toJSON()))

    _.each [ 'library', 'graveyard', 'exile' ], (collection) =>
      @components[collection] = new Dropbox({ model: @model[collection] })
      @el.append(@components[collection].el)

    @components['hand'] = new HandView({ model: @model.hand });

    root = if @model.local then 'left' else 'right'
    $("##{root}-panel .users").append(@el)


  render: =>
    @$('.lives').val @model.lives()
    _.each @components, (box) ->
      box.render()