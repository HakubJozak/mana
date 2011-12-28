jQuery.fn.reverse = [].reverse

_.mixin {
  preventing_wrap: (f) ->
    (event) ->
      f.call(this, event)
      event.preventDefault()
      event.stopPropagation()

  preventer: (f, event) ->
    event.preventDefault()
    event.stopPropagation()
    f(event)
}