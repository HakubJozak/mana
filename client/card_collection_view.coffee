class CardCollectionView extends Backbone.View

  constructor: (attrs) ->
    super(attrs)

    @model.bind 'add', @render
    @model.bind 'change', @render

    clazz = @constructor.name.toLowerCase()
    @template = _.template($("##{clazz}-template").html())
    @el = $(@template({ name: @model.name }))
