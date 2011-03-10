class UserView extends Backbone.View

  @tagName: 'div'
  @className: 'user'

  constructor: ->
    super
    @model.bind 'change', @render
    @dropboxes = {}
    @template = _.template($('#user-template').html())
    @el = $(@template(@model.toJSON()))

    _.each [ 'library', 'graveyard', 'exile' ], (collection) =>
      @dropboxes[collection] = new Dropbox({ model: @model[collection] })
      @el.append(@dropboxes[collection].el)

    $("#users").append(@el)


  render: =>
   @$('.lives').text(@model.lives)
   _.each @dropboxes, (dropbox) ->
     dropbox.render()