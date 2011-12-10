#!/bin/bash

bundle exec unicorn & tail -f log/development.log
