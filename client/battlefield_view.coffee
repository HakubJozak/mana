class BattlefieldView extends Backbone.View

  @tagName: 'div'
  @className: 'battlefield'

  constructor: (attrs) ->
    super(attrs)

    @user_area_template = _.template($('#user-area-template').html())
    @model.bind 'add', @render
    @model.bind 'change', @render
    @model.bind 'remove', @render

    @el = $('#battlefield')
    @el.droppable
      scope: 'cards'
      hoverClass: 'card-over'
      drop: @dropped
      accept: (draggable) ->
        ($('.card-over' ).length < 2) && draggable.hasClass('card');

  render: =>
    console.info 'rendering field'
    @model.each (card) =>
      view = CardView.find_or_create(card)
      # DRY - it is CardCollectionView#_attach_card method
      unless view.el.parent().tagName == 'BODY'
        old = @to_relative(view.el.offset())
        view.el.detach
        view.el.appendTo('body')
        view.el.offset(@to_global(old))

      view.el.animate(@to_global(card.position()))

  dropped: (event,ui) =>
    p = ui.draggable.offset()
    card = ui.draggable.ob().model
    card.move_to(@model, { silent: true })
    card.set({ position: @to_relative(p) }, { silent: true })
    @render()
    card.save()

  to_global: (p) =>
    origin = @el.offset()
    return {
      top:  p.y + @el.offset().top,
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
