# Mana

Mana is a proof-of-concept in-browser implementation of Magic the Gathering(tm) card game using jQuery, EventMachine, Sinatra, Compass and Websockets. Pre-pre-alpha stage.


## Live Server

Try it yourself! (__WARNING: the server has very limited resources and might go offline unexpectedly.__).

[http://83.167.232.160/games/any-name](http://83.167.232.160/games/any-name)

and replace 'any-name' by a name of your choice. Send the URL to your friend(s) and play! The controls are very simple:

![Screenshot](https://github.com/HakubJozak/mana/raw/master/screenshots/1.png)

## Controls
### Mouse
 - drag & drop does most of the actions
 - left click shows the detail
 - right click taps/untaps the card

### Keyboard
 <t> - turns over the highlighted card
 <m> - send chat message to other players
 <spacebar> - show/hide hand

## Requirements 

### Client

Webkit-based browser (developed in Chrome) - for now. It is quite easy to make it cross-browser but right now the focus is on core features.

### Server

   - Ruby 1.9.2
   - Bundler
   - Node.js (for coffe script)

## TODO

### Essential - Alfa
 - counters
 - simple chat
 - tokens

### Beta
 - lobby synchronization
 - welcome site in Rails3

### Convenience
 - life counter
 - inform all users about other users' actions
 - history recording & match replays
 - variable width and height of the battleground
 - advanced shortcuts
 - select more cards + save selection (C&C style)
 - untap all / selected cards
 - zooming
 - each user has its own color
 - Gravatar - http://railscasts.com/episodes/244-gravatar
 - http://headjs.com/
 - cheating prevention

## Contributions

All contributions are welcome! The graphics needs rework (right now it is in-fact "borrowed" from http://tappedout.net), tests have to be written and a lot of features that are easy to implement but not so critical plea for attention. Just fork the repository and send me the pull request or write me a message on Github. If you don't know where to start, see the TODO list.

## Licence

(TODO - choose one)

## Copyright

Copyright &copy; 2011 Jakub Hozak
