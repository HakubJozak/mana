#!/bin/bash

cd ./backend && export RACK_ENV=development BUNDLE_GEMFILE=../Gemfile && bundle exec ruby ./backend.rb localhost 9090
