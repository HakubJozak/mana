Mana.Droppable = Ember.Mixin.create(Mana.JQueryUIBase,
  uiType: "droppable"
  uiOptions: [
        "accept"
        "activeClass"
        "addClasses"
        "disabled"
        "greedy"
        "hoverClass"
        "scope"
        "tolerance"
  ]
  uiEvents: [
        "activate"
        "create"
        "deactivate"
        "drop"
        "out"
        "over"
  ]
)
