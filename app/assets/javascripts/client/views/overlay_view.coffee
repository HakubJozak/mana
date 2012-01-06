class OverlayView extends Backbone.View

  @HTML = """
           <div id='overlay-container' class='overlay' >
             <div class='info'>
                <h1></h1>
                <p></p>
             </div>
           </div>
          """

  initialize: =>
    @model.bind 'socket:connected', @hide
    @model.bind 'socket:disconnected', @show
    @el = $(OverlayView.HTML)
    @el.appendTo('body')

  show: =>
    @$('h1').text('Disconnected')
    @$('p').text('Please refresh the page to reconnect.')
    @el.fadeIn()

  hide: =>
    @el.fadeOut()

window.OverlayView = OverlayView