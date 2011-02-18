module 'card'


test '', ->
  equals(QUnit.equiv(null, null), true, "neco jinyho null")
  equals(QUnit.equiv(null, {}), true)
