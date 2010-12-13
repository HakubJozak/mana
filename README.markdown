# Mana

Mana is a proof-of-concept in-browser implementation of Magic the Gathering(tm) card game using jQuery, EventMachine, Sinatra, Compass and Websockets. Pre-pre-alpha stage.


## Demo

Try it yourself! (__WARNING: the server has very limited resources and might go offline unexpectedly.__).

[http://83.167.232.160/games/any-name](http://83.167.232.160/games/any-name)

and replace 'any-name' by a name of your choice. Send the URL to your friend(s) and play! The controls are very simple:

 - drag & drop does most of the actions
 - left click shows the detail
 - CTRL + left click covers/uncovers a card
 - right click taps/untaps the card

![Screenshot](https://github.com/HakubJozak/mana/raw/master/screenshots/1.png)

## Contributions

All contributions are welcome! The graphics needs rework (right now it is in-fact "borrowed" from http://tappedout.net), tests have to be written and a lot of features that are easy to implement but not so critical plea for attention. Just fork the repository and send me the pull request or write me a message on Github. If you don't know where to start, see the TODO list.

## Requirements

Webkit-based browser (developed in Chrome) - for now. It is quite easy to make it cross-browser but right now the focus is on core features.

## TODO

 - searching library
 - putting cards to library
 - lobby synchronization
 - shuffle trigger
 - counters
 - tokens
 - variable width and height of the battleground
 - zooming
 - simple chat
 - each user has its own color
 - security




