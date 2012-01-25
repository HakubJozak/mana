class PopupView extends Backbone.View

  @HTML = """
           <ul class='popup'>
           </ul>
          """

  initialize: =>
    @el = $($.mustache(PopupView.HTML, @model))
    @el.appendTo('body')

