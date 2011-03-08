class UserView extends Backbone.View

  @tagName: 'div'
  @className: 'user'

  constructor: ->
    super
    @model.bind 'change', @render
    @template = _.template($('#user-template').html())
    @el = $(@template(@model.toJSON()))

    _.each [ 'library', 'graveyard', 'exile' ], (collection) =>
      view = new Dropbox({ model: @model[collection] })
      @el.append(view.el)

    $("#users").append(@el)



  render: =>
   @$('.lives').text(@model.lives)