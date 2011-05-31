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

  def qunit_skeleton
    page.execute_script %{
      jQuery('body').prepend(
        '<div id="qunit">' +
        '<h1 id="qunit-header">Mana QUnit tests</h1>' +
        '<h2 id="qunit-banner"></h2>' +
        '<div id="qunit-testrunner-toolbar"></div>' +
        '<h2 id="qunit-userAgent"></h2>' +
        '<ol id="qunit-tests"></ol>' +
        '</div>'
      );

      $('head').append('<link rel="stylesheet" href="/tests/qunit.css"/>');
      jQuery.getScript('/tests/jquery.simulate.js');
      jQuery.getScript('/tests/qunit.js', function(){
        QUnit.init();
      });
    }
  end

end
