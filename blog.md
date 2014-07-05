# Walls I Hit When Driving through Ember.js

## Rails Assets Helpers in Handlebars

When I deployed to Heroku for the first time I realized that my static assets are broken. Well, of course they were. They were all hard-wired for the sake of quick & dirty development. Now while it is easy to fix this in an ERB or SCSS just by changing

```ruby
    <%= '/assets/meme.png' %>

to

```ruby
    <%= image_path('meme.png') %>

it was a bit harder to figure out, where exactly should I put this bit when dealing with `ember-rails` and a handlebars template. As far as I sought, I haven't found a built-in handlebars helper that

## Wall #1: Calling a Model inside Ember.js View

When reading the docs I was taking for granted that with each Ember.js view, you have its
model at your disposal. Well, you have. But it is not as straight-forward as I was imagining it. You cannot just call `@get('name')` in an Ember.View instance and it took me a LONG while to figure out a simple thing, that has to be obvious to every Ember.js developer used to that. Well, here it. Doors for all those who are trying to climb the same wall that I did.

So let's say you have a simple model like this:

```coffeescript
    App.Player = DS.Model.extend
      name: DS.attr 'string'

and you are trying to list all the players:

```handlebars
  <ul>
  {{#each players}}
    <li>{{ name }}</li>
  {{/each}}
  </ul>

and all works as expected. Then, you want to use that in the view context and suddenly, your head goes sideway. Maybe. Mine did.

```coffeescript
    App.PlayerView = Ember.View.extend
      click: (event) ->
        console.info @get('name')

So, naively, I was expecting that the view is proxying all my calls to a model, just like `Ember.ObjectController` does. Well, it isn't. A pole I used to jump over that wall was a wooden one, but it worked. I called the handlebars view helper and set the model into some view property:

```handlebars
  {{#view App.PlayerView content=this }}
    ...
  {{/view}}

which allowed me to do:

```coffeescript
    console.info @get('content.name')

It worked but it was more like a shin than shining. There had to be a simple way that everybody is using that I am just missing, I thought. And there is!

```coffeescript
    console.info @get('context.model.name')

This is where the model is buried. Please ignore all the code samples above. This is the right one and you don't need anything else.
__Those who know more about Ember please don't hesitate to point out that this is not the right way and tell me which one is in the comments! __
