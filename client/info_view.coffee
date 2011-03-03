class InfoView extends Backbone.View

  initialize: ->
    @el = $('#infobox')
    Chat.instance.bind ''

  render: (msg) =>
    output = $('#infobox p:first');
    output.append( msg.toString() + "<br/>");

    unless @el.is(':visible')
      @el.show('fade').delay(5000).hide 'fade', ->
        $('#infobox p:first').html('')
