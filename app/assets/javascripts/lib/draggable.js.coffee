Mana.Draggable = Ember.Mixin.create(Mana.JQueryUIBase,
  uiType: "draggable"
  uiOptions: [
    "disabled"
    "addClasses"
    "appendTo"
    "axis"
    "cancel"
    "connectToSortable"
    "containment"
    "cursor"
    "delay"
    "distance"
    "grid"
    "handle"
    "snap"
    "snapMode"
    "stack"
  ]
  uiEvents: [
    "create"
    "start"
    "drag"
    "stop"
  ]
)
