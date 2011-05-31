Given /^(?:|I )am on (.+) playing$/ do |page_name|
  visit path_to(page_name)
  When 'I press "Play" within the "Lobby" dialog'
  Then 'I wait until "#left-panel" is visible'
end