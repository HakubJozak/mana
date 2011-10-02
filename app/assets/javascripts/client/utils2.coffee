_.mixin {
  preventer: (f, event) ->
    console.info 'preventing'
    event.preventDefault()
    event.stopPropagation()
    f(event)
}