Ember.Handlebars.helper 'capitalize', (str,options) ->
  str.capitalize()

Ember.Handlebars.helper 'card_stat', (value, options) ->
   if value?
     value
   else
     '-'


# Ember.Handlebars.helper 'capitalize', (value, options) ->
#   escaped = Handlebars.Utils.escapeExpression(value)
#   new Ember.Handlebars.SafeString('<span class="highlight">' + escaped + '</span>')
