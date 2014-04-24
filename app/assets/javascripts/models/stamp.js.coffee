# for more details see: http://emberjs.com/guides/models/defining-models/

Mana.Stamp = DS.Model.extend
  name: DS.attr 'string'
  url: DS.attr 'string'
  frontside: DS.attr 'string'
  backside: DS.attr 'string'
