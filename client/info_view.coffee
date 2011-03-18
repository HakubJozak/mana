class InfoView extends Backbone.View

  initialize: ->
    @el = $('#infobox')
    @output = $('#infobox p:first');
    @last = 0

  message_added: =>
    @render()

  render: (msg) =>
    @el.fadeIn()
    for i in [@last...@model.length]
      one = $('<span>' + @model.at(i).text() + '<br/></span>')
      @output.append(one)
      one.delay(6000).fadeOut()

    @last = @model.length