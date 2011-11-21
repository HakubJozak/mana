#!/bin/bash

cd ./backend && export RACK_ENV=test && bundle exec ruby ./backend.rb localhost 9090
