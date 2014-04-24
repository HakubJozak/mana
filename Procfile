web: bundle exec unicorn
backend: sh -c 'cd ./backend && RACK_ENV=development BUNDLE_GEMFILE=../Gemfile bundle exec ruby ./backend.rb localhost 9090'
