Given /^(?:|I )am on (.+) playing$/ do |page_name|
  visit path_to(page_name)
  When 'I press "Play" within the "Lobby" dialog'
  Then 'I wait until "#left-panel" is visible'
end

Given %r{^my name is #{REQUIRED}$} do |name|
  When %{I fill in "name" with "#{name}" within the "Lobby" dialog} if name.present?
  When 'I press "Play" within the "Lobby" dialog'
  Then 'I wait until "#left-panel" is visible'
  Then 'I wait 1 second'
end

When %r{^#{I}#{REQUIRED} the #{REQUIRED_PANEL}$} do |action, selector, section|
  within selector_for(selector) do
    click_on action
  end
end

Then %r{^#{I}should see #{REQUIRED} window with (\d+) cards$} do |window, cards|
  within ".#{window.underscore}.card-browser" do
    assert_equal cards.to_i, all('.card').count
  end
end

Then %r{^#{I}should not see #{REQUIRED_PANEL}$} do |selector, section|
  refute find(selector_for(selector)).visible?
end

When %r{^#{I}grab first card from #{REQUIRED_PANEL}$} do |selector, section|
  within selector_for(selector) do
    @card = all('.card').first
  end

  refute_nil @card
end

When %r{^#{I}drag the card to my hand$} do
  refute_nil @card
  puts @card
  @card.drag_to(my_hand)
end

Then %r{^#{I}should see the card in my hand$} do
  refute_nil @card

  within selector_for('my hand') do
    find "##{@card[:id]}"
  end
end
