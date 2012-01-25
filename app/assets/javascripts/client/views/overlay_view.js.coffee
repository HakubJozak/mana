class OverlayView extends Backbone.View

  @HTML = """
           <div id='overlay' class='overlay-container' >
             <div class='info'>
                <h1>Connecting</h1>
                <p>Please wait...</p>
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