class UserView extends Backbone.View

  @tagName: 'div'
  @className: 'user'

  constructor: ->
    super
    @model.bind 'change', @render
    @template = _.template($('#user-template').html())
    @el = $(@template(@model.toJSON()))
    $("#users").append(@el)
    @el.append(new Dropbox({ model: @model.graveyard }).el)


  render: =>
   @$('.lives').text(@model.lives)