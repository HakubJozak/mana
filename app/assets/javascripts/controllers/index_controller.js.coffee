# for more details see: http://emberjs.com/guides/controllers/

Mana.IndexController = Ember.ObjectController.extend({
  battlefield: (->
    b = []
    for i in [0..15]
      b.pushObject []
    b).property()
})
