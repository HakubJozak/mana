class User

  @find: (id) ->
    $("#user-#{id}").ob()

  @local: ->
    $("#user-local").ob()

  constructor: (attrs) ->
    @name = attrs.name
    @color = attrs.color
    @id = attrs.id
    @counter = 0

  to_dom_id: ->
    "user-#{@id}"

  create_unique_id: ->
    "#{this.to_dom_id()}-created-#{@counter++}"


