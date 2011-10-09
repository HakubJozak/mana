$(document).ready ->
  $('#color-picker').farbtastic (color,second) ->
    $('#player_color').css('color', color)
               .val(color)

  $('#player_color').click -> $('#color-picker').fadeIn()
  $('#player_color').focus -> $('#color-picker').fadeIn()
  $('#player_color').blur -> $('#color-picker').fadeOut()
