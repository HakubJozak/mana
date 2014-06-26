# -*- mode: css; tab-width: 2; -*-
# for more details see: http://emberjs.com/guides/models/defining-models/

Mana.Message = DS.Model.extend
  author: DS.attr 'string'
  text: DS.attr 'string'
