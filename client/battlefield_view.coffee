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
      accept: (draggable) ->
        ($('.card-over' ).length < 2) && draggable.hasClass('card');

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
    sorter = (u) -> u.id
    _.each User.all.sortBy(sorter), (user) =>
      area = $(@user_area_template(user))
      area.addClass('local') if user.local
      @el.append(area)

  render: =>
    @model.each (card) =>
      view = CardView.find_or_create(card)
      # TODO: DRY and optimize
      view.el.detach
      view.el.appendTo('body')
      view.el.animate(@to_global(card.position()))
