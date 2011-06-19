# Mana

Mana is a proof-of-concept in-browser implementation of Magic the Gathering(tm) card game using jQuery, EventMachine, Sinatra, Compass and Websockets. Pre-alpha stage. The main aim is to be able to play Magic the Gathering via internet without any client-side setup (downloading cards, installing client ...). Any rules enforcing or checks are far beyond the scope however.


![Screenshot](https://github.com/HakubJozak/mana/raw/master/screenshots/1.png)


## Live Server

Try it yourself!

[http://83.167.232.160/games/any-name](http://83.167.232.160/games/any-name)

and replace 'any-name' by a name of your choice. Send the URL to your friend(s) and play!

__WARNING 1__: the server has very limited resources and might go offline unexpectedly.

__WARNING 2__: anyone who knows little about HTML or JavaScript can cheat, so choose your opponents with care ;)

__WARNING 3__: I am almost sure there are security issues (XSS and such), don't say I did not warn you! (see TODO)

## Requirements

### Client

Webkit-based browser (developed in Chrome) - for now. It is quite easy to make it cross-(modern)-browser but right now the focus is on the core features.

### Server

   - Ruby 1.9.2
   - Bundler + all the gems in Gemfile...
   - MongoDB
   - Node.js (for Coffee script compiling)

## TODO

### Bugs
 - card stacking on drop does not work remotely


### Essential - Alfa
 - disconnect recovery
 - number of cards in hand

### Early Beta +
 - lobby synchronization
 - reconnect on connection failure
 - welcome site in Rails3
 - security (escape custom card links and check they are images)
 - prevent XSS

### More Features Convenience - Versions 1+

 - saving - (each player obtains unique URL to connect to the old game as a same user)
 - counters on the cards
 - link the cards to MagicCardsInfo (to see errata and stuff in a new window)
 - visible shuffling effect
 - inform all users about (all) other users' actions
 - history recording & match replays
 - variable width and height of the battleground
 - advanced keyboard shortcuts
 - select more cards + save selection (C&C style)
 - untap all / selected cards
 - smart image loading (+ show dummy before card image is loaded)
 - zooming
 - Gravatar - http://railscasts.com/episodes/244-gravatar
 - http://headjs.com/
 - cheating prevention
 - use backbone.js and moustache.js

## Contributions

All contributions are welcome! The graphics needs rework (right now it is in-fact "borrowed" from http://tappedout.net), tests have to be written and a lot of features that are easy to implement but not so critical plea for attention. Just fork the repository and send me the pull request or write me a message on Github. If you don't know where to start, see the TODO list.


## History
23/10/2010 - First commit
14/02/2011 - First game succesfully played and finished (Kolohnat X Kvetak)

## Licence

(TODO - choose one)

## Copyright

Copyright &copy; 2011 Jakub Hozak
