# for more details see: http://emberjs.com/guides/models/defining-models/

Mana.Stamp = DS.Model.extend
  name: DS.attr 'string'
  url: DS.attr 'string'
  frontside: DS.attr 'string'
  backside: DS.attr 'string'


Mana.Stamp.FIXTURES = [
  {
    id: '1'
    name: "Forest"
    frontside: "http://mtgimage.com/multiverseid/289.jpg"
    backside: null
  }
  {
    id: '2'
    name: "Child of the Night"
    frontside: "http://mtgimage.com/multiverseid/221212.jpg"
    backside: "http://mtgimage.com/multiverseid/221222.jpg"
  }
]
