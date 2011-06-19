require 'bundler/setup'
Bundler.require :default, :test

require 'test/unit/capybara'
require 'capybara-webkit'
require 'bermuda/xpath'

Capybara.run_server = false
Capybara.default_driver = :webkit
Capybara.app_host = 'http://localhost:3000'


class Test::Unit::TestCase
  include Capybara

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

  def build_qunit_skeleton
    page.execute_script %{
      jQuery('head').append('');
      jQuery.getScript('/tests/jquery.simulate.js');

      jQuery('body').prepend(
        '<div id="qunit">'
        '<h1 id="qunit-header">Mana QUnit tests</h1>' +
        '<h2 id="qunit-banner"></h2>' +
        '<div id="qunit-testrunner-toolbar"></div>' +
        '<h2 id="qunit-userAgent"></h2>' +
        '<ol id="qunit-tests"></ol>' +
        '</div>'
      );

      jQuery.getScript('/tests/qunit.js', function(){
        QUnit.init();
      });

    }
  end




end
