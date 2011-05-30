task :default => :test

desc 'Run all *_test.rb files in test folder'
task :test do
  Dir['client/test/integration/*_test.rb'].each {|test| require File.expand_path(test) }
end


require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "--require features --format pretty --guess features"
end