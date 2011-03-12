class BattlefieldView extends Backbone.View

  @tagName: 'div'
  @className: 'battlefield'

  constructor: (attrs) ->
    super(attrs)

    @user_area_template = _.template($('#user-area-template').html())
    @model.bind 'add', @render
    @model.bind 'change', @render

    @el = $('#battlefield')
    @el.droppable
      scope: 'cards'
      hoverClass: 'card-over'
      drop: @dropped

  dropped: (event,ui) =>
    p = ui.draggable.offset()
    card = ui.draggable.ob().model
    card.move_to(@model, { silent: true })
    card.set({ position: @to_relative(p) }, { silent: true })
    card.save()

  to_global: (p) =>
    origin = @el.offset()
    return {
      top: p.y + @el.offset().top,
      left: p.x + @el.offset().left
    }

  to_relative: (p) =>
    origin = @el.offset()
    top =  p.top - origin.top
    left = p.left - origin.left
    return { y: top, x: left }

  render_user_areas: =>
    @el.find('.user-area').remove()
    User.all.each (user) =>
      @el.append(@user_area_template(user))

  render: =>
    @model.each (card) =>
      console.info card
      view = CardView.find_or_create(card)
      console.info @to_global(card.position())
      view.el.animate(@to_global(card.position()))
