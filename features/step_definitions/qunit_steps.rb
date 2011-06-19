When /^(?:|I )integrate QUnit$/ do
  find('#qunit #qunit-tests')

  Then 'I wait 1 second'
end

When /^(?:|I )run (.+?) (?:(integration|unit) )?tests?$/ do |tests, suite|


end

Then /^(?:|I )should (not )?see (some|any) QUnit errors$/ do |should, count|
end
