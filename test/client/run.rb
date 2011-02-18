#!/usr/bin/env ruby


server = 'http://localhost:4567'
suite = Dir['tests/*.js'].map do |file|
  uri = file.gsub(/tests(.*)\.js/,'suites\1.html')
  "#{server}/#{uri}"
end

browser = "chromium-browser --new-window  #{suite.join(' ')}"
puts browser
exec browser
