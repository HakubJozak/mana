class Visibility

  toggle_visible: ->
    @visible = !@visible
    @render()

  render: ->
    if @visible
      @el.fadeIn()
      @_render_if_visible()
    else
      @el.fadeOut()

    this
