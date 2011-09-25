class Dialog extends Backbone.View

  @tagName: 'div'
  @className: '.dialog'

  constructor: (params) ->
    super(params)
    @el.dialog {
      autoOpen: false,
#      width: '95%',
      height: '95',
      modal: false,
      open: -> console.info('opened')
#      buttons: [  { text: 'Play', click: @submit  }  ]
    }

  open: =>
    @el.dialog('open')
