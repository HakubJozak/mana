class Dropbox extends Backbone.View

  @tagName: 'div'
  @className: 'box'

  constructor: (attrs) ->
    super(attrs)

    @model.bind 'add', @render
    @model.bind 'change', @render

    @template = _.template($('#dropbox-template').html())
    @el = $(@template({ name: @model.name }))
    @box = @el.find('.box')
    @box.droppable
      scope: 'cards'
      greedy: true
      hoverClass: 'card-over'
      drop: @dropped

  tappingAllowed: -> false

  dropped: (event,ui) ->
    card = ui.draggable.ob().model
    @fixPosition(card);
    p = card.el.offset();
    card.change_position
      container: 'battlefield'
      x: p.left,
      y: p.top

  fixPosition: ->
    if @unpacked()
      @spread_cards(5, @el.width())
    else
      p = @el.offset()
      p.top += 5
      p.left += 5
      card.change_position(p)

  render: =>
    console.info 'view'

    if @model.first()
      card = new CardView({ model: @model.first() })
      card.render()
      card.el.css('position','absolute')
      card.el.offset({ top: 5, left: 5 })
      @box.append(card.el)
      # p = @el.offset()
      # p.top += 5
      # p.left += 5
      # card.el.offset(p)
      # console.info card
      # card.render()
      # @el.append(card.el.css('position','absolute'))
    else
      console.info @model
