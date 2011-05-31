Given /^(?:|I )am on (.+) playing$/ do |page_name|
  visit path_to(page_name)
  When 'I press "Play" within the "Lobby" dialog'
  Then 'I wait until "#left-panel" is visible'
end

Given %r{^my name is #{REQUIRED}$} do |name|
  When %{I fill in "name" with "#{name}" within the "Lobby" dialog} if name.present?
  When 'I press "Play" within the "Lobby" dialog'
  Then 'I wait until "#left-panel" is visible'
end

When %r{^I #{REQUIRED} the #{REQUIRED} in (my|oponent\'?s) panel$} do |action, section, panel|
  puts action, section, panel
end

Then %r{^I should see #{REQUIRED} window with (\d+) cards$} do |window, cards|
  pending
end

Then %r{^I should not see #{REQUIRED} in my panel$} do
  pending
end
