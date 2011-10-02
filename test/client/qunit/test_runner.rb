require 'bundler/setup'
Bundler.require :default, :test

require 'test/unit/capybara'
require 'capybara-webkit'
require 'bermuda/xpath'

Capybara.run_server = false
Capybara.default_driver = :webkit
Capybara.app_host = 'http://localhost:3000'



class QunitTest < Test::Unit::TestCase

  include Capybara

  # def setup
  # end

  # def teardown
  # end

  tests = Dir['test/qunit/*.coffee']
  puts "Loading qunit tests: #{tests.join(', ')}"

  tests.each do |file|
    name = File.basename(file, '.coffee')

    define_method('test_' + name) do
      visit '/tests/qunit?headless=1'

      page.execute_script %{
        jQuery.getScript('/tests/qunit/#{name}.js', function(){
          console.info('Finished QUnit test: #{name}');
        });
      }

      # HACK: wait for the tests to finish
      sleep 3

      # puts page.body
      # puts page.evaluate_script('document.total')

      grab_qunit_errors
    end
  end

  private

  def grab_qunit_errors
    failed, passed, total = nil

    within 'p#qunit-testresult' do
      passed = find('.passed').text.to_i
      failed = find('.failed').text.to_i
      total = find('.total').text.to_i
    end

#    assert_equal total, failed + passed, 'There were some errors'
    assert_equal 0, failed, "#{failed} QUnit failures"
  end

end
