task :default => :test


desc 'Run all tests'
task :test => [ :qunit, :integration ] do
end



desc 'Run integration tests'
task :integration do
  Dir['test/integration/*_test.rb'].each {|test| require File.expand_path(test) }
end


desc 'Runs all purely qunit tests'
task :qunit do

end


require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "--require features --format pretty --guess features"
end
