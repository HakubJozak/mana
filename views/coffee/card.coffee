# set Moustache style templates for Underscore
_.templateSettings = {
  interpolate : /\{\{(.+?)\}\}/g
}

class Card extends Backbone.Model

  defaults:
    # TODO: put loading image here
    image: 'http://example.com/unknown.jpg'
    covered: false
    tapped: false
    counters: 0
    power: 0
    toughness: 0

  initialize: ->
    throw 'Missing card ID' unless @id

  toggle_covered: (state = null) ->
    state ||= !@get('covered')
    @set({ covered: state })
    this

  toggle_tapped: (state = null) ->
    state ||= !@get('tapped')
    @set({ tapped: state })
    this

  tapped: -> @get('tapped')

  covered: -> @get('covered')

  image: -> @get('image')

  name: -> @get('name')


class CardView extends Backbone.View

  @BACK_SIDE: "/images/back.jpg"
  @tagName: 'div'
  @className: 'card'

  constructor: ->
    super
    @model.bind 'change', @render
    @template = _.template($('#card-template').html())

    @el = $(@template(@model.toJSON()))
    @el.data('view',this)

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

  clicked: (e) ->
    e.preventDefault()
    e.stopPropagation()

    if e.button == 2
      @model.toggle_tapped()
    else
      @show_detail()

  initialize: ->
    _.bindAll(this, "render")
    _.bindAll(this, 'clicked', 'show_detail')

  render: ->
    if @model.covered() then '/images/back.jpg' else @model.image()
    if @model.tapped $(@el).addClass('tapped') else $(@el).removeClass('tapped')
    this

  show_detail: ->
    return if @model.covered()

    detail = @el.find('img').clone()
    $('body').append(detail)

    # TODO: template
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




class CardCollection extends Backbone.Collection
  model : Card

  constructor: ->
    super
#    @refresh($FOURSQUARE_JSON)
