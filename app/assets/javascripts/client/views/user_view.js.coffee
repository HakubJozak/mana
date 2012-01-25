class UserView extends Backbone.View

  @HTML = """
   <div class='user' id='user-{{id}}'>
    <h3 class='name'>{{name}}</h3>
    <table>
      <tr>
        <th>Lives</th>
        <td>
          <a class='button small plus'>+</a>
          <a class='button small minus'>&nbsp;-&nbsp;</a>
        </td>
        <td>
          <form>
            <input class='lives' value='20' />
          </form>
        </td>
      </tr>
      <tr>
        <th>Hand</th>
        <td>
          <span class='hand-browse-button icon icon-browse' title='Browse' ></span>
        </td>
        <td>
          <input class='hand-size' disabled='disabled' />
        </td>
      </tr>
    </table>
  </div>
  """

  @tagName: 'div'
  @className: 'user'

  constructor: (attrs) ->
    super(attrs)
    $('head').append(_.template($('#user-stylesheet-template').html(), @model.toJSON()))

    @components = {}
    @el = $($.mustache(UserView.HTML, @model))

    @model.bind 'change', @render
    @model.hand.bind 'add', @render
    @model.hand.bind 'remove', @render

    @$('form').submit @lives_changed
    @$('.plus').click => @change_lives(1)
    @$('.minus').click => @change_lives(-1)

    @$('.hand-browse-button').click =>
      if confirm("Do you really want to browse #{@model.name()}'s to hand?")
        new CardBrowser(model: @model.hand)

    @components.library = new Dropbox(model: @model.library, shuffle: @model.local)
    @components.graveyard = new Dropbox(model: @model.graveyard, shuffle: @model.local )

    @el.append(@components.library.el)
    @el.append(@components.graveyard.el)

  change_lives: (delta) =>
    lives = @$('input.lives').val()
    @$('input.lives').val(parseInt(lives) + delta)
    @$('form').submit()

  lives_changed: =>
    lives = parseInt(@$('input.lives').val())
    @model.set(lives: lives)
    @model.save()
    return false

  render: =>
    @$('.lives').val(@model.lives())
    @$('.hand-size').val(@model.hand.size())


window.UserView = UserView
