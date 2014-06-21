# Create a new mixin for jQuery UI widgets using the new SproutCore 2.0
# mixin syntax.
Mana.JQueryUIBase = Ember.Mixin.create(

  # When SproutCore creates the view's DOM element, it will call this
  # method.
  didInsertElement: ->
    @_super()

    # Make jQuery UI options available as SproutCore properties
    options = @_gatherOptions()

    # Make sure that jQuery UI events trigger methods on this view.
    @_gatherEvents options

    # Create a new instance of the jQuery UI widget based on its `uiType`
    # and the current element.
    ui = jQuery.ui[@get("uiType")](options, @get("element"))

    # Save off the instance of the jQuery UI widget as the `ui` property
    # on this SproutCore view.
    @set "ui", ui
    return


  # When SproutCore tears down the view's DOM element, it will call
  # this method.
  willDestroyElement: ->
    ui = @get("ui")
    if ui

      # Tear down any observers that were created to make jQuery UI
      # options available as SproutCore properties.
      observers = @_observers
      for prop of observers
        @removeObserver prop, observers[prop]  if observers.hasOwnProperty(prop)
      ui._destroy()
    return


  # Each jQuery UI widget has a series of options that can be configured.
  # For instance, to disable a button, you call
  # `button.options('disabled', true)` in jQuery UI. To make this compatible
  # with SproutCore bindings, any time the SproutCore property for a
  # given jQuery UI option changes, we update the jQuery UI widget.
  _gatherOptions: ->
    uiOptions = @get("uiOptions")
    options = {}

    # The view can specify a list of jQuery UI options that should be treated
    # as SproutCore properties.
    uiOptions.forEach ((key) ->
      options[key] = @get(key)

      # Set up an observer on the SproutCore property. When it changes,
      # call jQuery UI's `setOption` method to reflect the property onto
      # the jQuery UI widget.
      observer = ->
        value = @get(key)
        @get("ui")._setOption key, value
        return

      @addObserver key, observer

      # Insert the observer in a Hash so we can remove it later.
      @_observers = @_observers or {}
      @_observers[key] = observer
      return
    ), this
    options

  # call in didInsertElement to set initial options of the jQuery plugin
  setup_ui: (settings) ->
    for k,v of settings
      @get('ui').option(k,v)

  # Each jQuery UI widget has a number of custom events that they can
  # trigger. For instance, the progressbar widget triggers a `complete`
  # event when the progress bar finishes. Make these events behave like
  # normal SproutCore events. For instance, a subclass of JQ.ProgressBar
  # could implement the `complete` method to be notified when the jQuery
  # UI widget triggered the event.
  _gatherEvents: (options) ->
    uiEvents = @get("uiEvents") or []
    self = this
    uiEvents.forEach (event) ->
      callback = self[event]
      if callback

        # You can register a handler for a jQuery UI event by passing
        # it in along with the creation options. Update the options hash
        # to include any event callbacks.
        options[event] = (event, ui) ->
          callback.call self, event, ui
          return
      return

    return
)
