When /^(?:|I )integrate QUnit$/ do
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
  find('#qunit #qunit-tests')
  
  Then 'I wait 1 second'
end

When /^(?:|I )run (.+?) (?:(integration|unit) )?tests?$/ do |tests, suite|
  
  tests = tests.split(/ and | +|, +?/)
  suite ||= 'unit'
  
  puts "Loading #{suite} tests: #{tests.join(', ')}"
  
  tests.each do |test|
    page.execute_script %{
      jQuery.getScript('/javascripts/tests/#{suite}/#{test}_test.js', function(){
        QUnit.start();
      });
    }
  end
  
end

Then /^(?:|I )should (not )?see (some|any) QUnit errors$/ do |should, count|
  should = should.strip.to_sym == :not ? false : true

  failed, passed, total = nil
   
  within '#qunit-testresult' do
    passed = find('.passed').text.to_i
    failed = find('.failed').text.to_i
    total = find('.total').text.to_i
  end
  
  assert total.to_i > 0, 'Total tests equal 0'
  
  assert_equal total, failed + passed
  
  if should 
    assert failed > 0, 'Some tests should fail'
  else
    assert failed == 0, 'All tests should pass'
  end
end
