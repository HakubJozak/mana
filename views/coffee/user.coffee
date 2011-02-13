class User

  @find: (id) ->
    $("#user-#{id}").object()

  @local: ->
    $("#user-local").object()

  constructor: (attrs) ->
    @name = attrs.name
    @color = attrs.color
    @id = attrs.id
    @counter = 0

  to_dom_id: ->
    "user-#{@id}"

  create_unique_id: ->
    "#{this.to_dom_id()}-created-#{@counter++}"


