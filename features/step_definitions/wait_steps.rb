Then /^(?:|I )wait until "([^\"]*)" is visible$/ do |selector|
  page.has_css?("#{selector}", :visible => true)
end

Then /^(?:|I )wait (\d+) seconds?$/ do |seconds|
  sleep seconds.to_i
end