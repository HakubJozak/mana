class OverlayView extends Backbone.View

  initialize: =>
    @model.bind 'socket:connected', @hide
    @model.bind 'socket:disconnected', @show
    @el = $('#overlay')

  show: =>
    console.info 'sdlkjfds'
    @$('h1').text('Disconnected')
    @el.fadeIn()

  hide: =>
    @el.fadeOut()

window.OverlayView = OverlayView