window.has_enough_mana = =>
  if window.WebSocket?
    return true
  else
    if window.MozWebSocket
      window.WebSocket = window.MozWebSocket;
      window.alert "Firefox is currently not supported although it 'almost works'. Either use some Webkit browser or continue and take the wild ride or fork Mana on Github and help me make it compatible with the Universe (42 lives needed)!"
      return true
    else
      window.alert "Sorry, Mana currently only works on Webkit browsers (tested in Chrome/ium). Either switch to one or fork Mana on Github and help it to be compatible with all (not IE6 of course)!"
      return false



