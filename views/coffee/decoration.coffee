class Decoration

  constructor: (params) ->
    @counters = params.counters
    @power = params.power
    @toughness = params.toughness
    @element = params.element

  adjust: (what) ->
    p = what['property']
    what['minus'] ? this[p]-- : this[p]++

    if p == 'counters'
      view = p
      text = this[p]
    else
      view = 'power';
      text = '' + @power + '/' + @toughness

    @element.find('.' + view).toggle(!what['clear']).text(text)
