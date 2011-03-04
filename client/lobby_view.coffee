class LobbyView

  constructor: ->
    $('#color-picker').farbtastic (color) ->
      $('#color-picker').fadeOut()
      $('#color').css('color', color)
                 .val(color)

    $('#color').click -> $('#color-picker').fadeIn()
    $('#color').focus -> $('#color-picker').fadeIn()
    $('#color').blur -> $('#color-picker').fadeOut()

    $('#lobby form').submit(@submit)
    $('#lobby').dialog {
      autoOpen: false,
      width: 400,
      modal: true,
      open: -> $(this).parent().find('.ui-dialog-titlebar-close').hide(),
      buttons: [  {
        text: 'Play',
        click: @submit
      }  ]
    }

  grab_input: (name) =>
    $('#lobby form *[name="' + name + '"]').val()

  is_valid: ->
    @grab_input('name') != ''

  message: (msg) ->
    $("#lobby-progress-message").text(msg)

  submit: =>
    if @is_valid
      Socket.instance.start_game( @grab_input('name'), @grab_input('cards'))

      $('button').attr('disabled',true)
      $('#lobby').dialog('close');
      $('button').attr('disabled',false);
      @message('Loading cards, please wait...')
    else
      @message('Please enter your name.')

    return false

  open: =>
    $('#lobby').dialog('open')


