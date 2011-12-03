#!/bin/bash

bundle exec unicorn_rails & tail -f log/development.log
