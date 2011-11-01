#!/bin/bash

cd ./backend && export RACK_ENV=development && bundle exec ruby ./backend.rb localhost 9090
