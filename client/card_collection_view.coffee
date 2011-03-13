class CardCollectionView extends Backbone.View

  constructor: (attrs) ->
    super(attrs)
    throw 'Missing model' unless @model

    @model.bind 'add', @render
    @model.bind 'change', @render

    clazz = @constructor.name.toLowerCase()
    @template = _.template($("##{clazz}-template").html())
    @el = $(@template(@model))
