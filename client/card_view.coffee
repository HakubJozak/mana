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
      scope: 'cards',
      snap: '.card',
      scroll: true,
      revert: 'invalid',
      containment: '#desk',
      snapMode: 'inner',
      zIndex: 9999
      stack: '.card',

    @el.bind 'click', @clicked
    @el.bind 'contextmenu', @clicked

    # LEGACY
    @el.data('game-object',this)
    @element = @el

  # LEGACY
  turnOverLocally: (state) ->
    value = if state then '/images/back.jpg' else @model.image()
    @el.find('img').attr('src',value)

  clicked: (e) ->
    e.preventDefault()
    e.stopPropagation()

    if e.button == 2
      @model.toggle_tapped()
    else
      @show_detail()

  initialize: ->
    _.bindAll(this, 'render', 'clicked', 'show_detail')

  render: =>
    if @model.hidden()
      @el.fadeOut()
    else
      @el.fadeIn()
      if @model.covered() then @set_image('/images/back.jpg') else @set_image(@model.image())
      if @model.tapped $(@el).addClass('tapped') else $(@el).removeClass('tapped')
# TODO: enable only for battlefield
#      @el.animate(@correct_position());

    this

  correct_position: ->
    p = @model.get('position')
    origin = @el.parent().offset();
    top =  p.y - origin.top;
    left = p.x - origin.left;
    { "top": top, "left": left }


  set_image: (img) ->
    @img.attr('src',img)

  show_detail: ->
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