# for more details see: http://emberjs.com/guides/views/

Mana.SlotView = Ember.CollectionView.extend
  templateName: 'slot'
  tagName: 'ul'
  itemViewClass: 'Mana.CardView'
