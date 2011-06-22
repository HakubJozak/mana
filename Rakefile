require 'cucumber/rake/task'

# require 'ruby-debug'
# Debugger.start

task :default => :test


desc 'Run all tests'
task :test => [ :qunit, :integration ] do
  Rake::TestTask.new(:test) do |t|
    t.libs << './ext'
    t.libs << './lib'
    t.libs << './cli'
    t.test_files = CLI_TEST_FILE_LIST
    t.verbose = true
  end
end


namespace :test do
  desc 'Run integration tests'
  task :integration do
    Dir['test/integration/*_test.rb'].each {|test| require File.expand_path(test) }
  end


  desc 'Runs all purely qunit tests'
  task :qunit do
    # TODO - run natively not externally
    system 'bundle exec ruby test/qunit/test_runner.rb'
  end

  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "--require features --format pretty --guess features"
  end
end
