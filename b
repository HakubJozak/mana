#!/bin/bash

cd ./backend && export RACK_ENV=development && bundle exec ./backend.rb localhost 9090
