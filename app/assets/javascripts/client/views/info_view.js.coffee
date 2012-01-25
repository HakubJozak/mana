class InfoView extends Backbone.View

  initialize: ->
    @el = $('#infobox')
    @output = $('#infobox p:first');
    @last = 0

  render: (msg) =>
    @el.fadeIn()
    for i in [@last...@model.length]
      msg = @model.at(i)
      one = $("<div><span class='user-#{msg.user.id}'>#{msg.user.name()}:</span> #{msg.text()}</div>")
      @output.append(one)
      one.delay(6000).fadeOut()

    @last = @model.length


window.InfoView = InfoView