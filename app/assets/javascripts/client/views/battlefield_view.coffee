class BattlefieldView extends CardCollectionView

  @tagName: 'div'
  @className: 'battlefield'

  initialize: (attrs) ->
    super(attrs)

    @user_area_template = _.template($('#user-area-template').html())

    @el = $('#battlefield')
    @el.droppable
      scope: 'cards'
      hoverClass: 'card-over'
      drop: @dropped
      accept: (draggable) ->
        ($('.card-over' ).length < 2) && draggable.hasClass('card');

  render: =>
    console.info 'rendering battlefield'
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
    old = card.collection

    card.set({ position: @to_relative(p) }, { silent: true })
    old.remove(card, { silent: true })
    @model.add(card, { silent: true })

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

window.BattlefieldView = BattlefieldView