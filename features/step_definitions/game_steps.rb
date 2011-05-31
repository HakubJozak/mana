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

When %r{^I #{REQUIRED} the #{REQUIRED} in my panel$} do |action, section|
  within ".side-panel #user-#{current_user} .#{section.underscore}-container" do
    click_on action
  end
end

Then %r{^I should see #{REQUIRED} window with (\d+) cards$} do |window, cards|
  within ".#{window.underscore}.card-browser" do
    assert_equal cards.to_i, all('.card').count
  end
end

Then %r{^I should not see #{REQUIRED} in my panel$} do |section|
  refute find(".side-panel #user-#{current_user} .#{section.underscore}-container").visible?
end
