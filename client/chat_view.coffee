class ChatView extends Backbone.View

  initialize: ->

    @model.bind 'add', @render

    @el = $('#chat-bar')
    @el.draggable()
       .keyup(@close_or_submit)
       .children('input')
       .blur()

  render: (msg) ->
    game.message @last().text()

  close_or_submit: (event) =>
    if event.keyCode == 27
      @close_chat()
    else if event.keyCode == 13
      @submit_chat()
      @close_chat()

  close_chat: ->
    @el.hide().children('input').blur()

  submit_chat: ->
    console.info '1211212'
    input = @el.find('input');

    # TODO: replace by create method
    message = new Message({ text: input.val() });
    message.save()
    @model.add message

    input.val('');
    false
