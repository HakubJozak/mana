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

  def setup
  end

  def teardown
    puts 'tearing down'
  end

  tests = Dir['test/qunit/*.coffee']
  puts "Loading qunit tests: #{tests.join(', ')}"

  tests.each do |file|
    name = file

    define_method('test_' + name) do
      visit '/tests/qunit?headless=1'
      page.execute_script %{
        jQuery.getScript('/javascripts/tests/#{name}_test.js', function(){
          QUnit.start();
        });
      }
    end
  end

  private

  def grab_qunit_errors
    failed, passed, total = nil

    within '#qunit-testresult' do
      passed = find('.passed').text.to_i
      failed = find('.failed').text.to_i
      total = find('.total').text.to_i
    end

    assert_equal total, failed + passed
    assert failed == 0, 'Some tests should fail'
  end

end
