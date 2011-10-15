class CardView extends Backbone.View

  @BACK_SIDE: "/images/back.jpg"
  @tagName: 'div'
  @className: 'card'

  constructor: (params) ->
    super(params)
    @model.bind 'change', @render
    @template = _.template($('#card-template').html())
    @el = $(@template(@model.toJSON()))
    @img = @el.find('img')

    @el.draggable
      position: 0,
      scope: 'cards',
      snap: '.card',
      scroll: true,
      revert: 'invalid',
      containment: 'body',
      snapMode: 'inner',
      zIndex: 9999
      stack: '.card',
      start: =>
        # HACK
        $('.overlay').trigger('mouseleave')

    @el.bind 'click', @clicked
    @el.bind 'contextmenu', @clicked


    # LEGACY
    @el.data('game-object',this)
    @element = @el


  clicked: (e) =>
    e.preventDefault()
    e.stopPropagation()

    if e.button == 2
      @model.toggle_tapped()
    else
      @show_detail()

  render: =>
    @el.find('.debug').text(@model.collection.name)
    @show_image()
    @show_tapping()
    @_render_overlay()
    @el.show()
    this

  _render_overlay: =>
    if @model.counters()
      @$('.counters').fadeIn().text(@model.counters())

    if @model.toughness() or @model.power()
      @$('.power').fadeIn().text("#{@model.power() || 0}/#{@model.toughness() || 0}")

  show_image: =>
    if  @model.covered()
      @img.attr('src','/assets/back.jpg')
    else
      @img.attr('src',@model.image())

  show_tapping: =>
    if @model.tapped()
      $(@el).addClass('tapped')
    else
      $(@el).removeClass('tapped')

  show_detail: =>
    return if @model.covered()

    # TODO: template it
    detail = @el.find('img').clone()
    $('body').append(detail)

    detail.css('z-index',10000)
        .attr('src', @model.image())
        .offset(@el.offset())
        .removeClass('card')
        .addClass('card-detail')
        .animate(CardView.detail_animation('+'), 200)

    detail.click ->
      $(this).unbind('click')
      $(this).animate CardView.detail_animation('-'), 200, ->
        $(this).remove()

  @detail_animation: (resize) ->
    reposition = if (resize == '+') then '-' else '+'

    return {
      left: reposition + '=60',
      top: reposition + '=85',
      height: resize + '=170',
      width: resize + '=120'
    }

window.CardView = CardView