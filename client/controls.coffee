class Controls

  constructor: ->
    _.extend(this, Backbone.Events);

    $(document).keypress (e) =>
      name = $(e.target)[0].nodeName;

      if name == 'INPUT' || name == 'TEXTAREA'
        return
      else
        @input(e)

      e.stopPropagation();
      e.preventDefault();

  input: (e) =>
    switch c = String.fromCharCode(e.keyCode)
      when 'u'
        cards = $('.card:hover')
        cards.ob().model.toggle_covered() if (cards.length > 0)

      when 'a'
        $('#create-card-dialog').dialog('open');

      when 'm'
        $('#chat-bar').toggle()
        $('#chat-bar input').focus()

      when 'h'
        $('#help').toggle()

      when 'c','C','t','T','p','P'
        props =
          c: 'counters'
          t: 'toughness'
          p: 'power'

        property = props[c.toLowerCase()]

        _.each @_selected_cards(), (card) ->
          delta = if e.shiftKey then -1 else 1
          card.adjust(property, delta )

      else
        @trigger('key:spacebar') if c == ' '
        # TODO: make it generic/register

  _selected_cards: ->
    _.map $('.card:hover'), (el) -> $(el).ob().model


Controls.current = new Controls()