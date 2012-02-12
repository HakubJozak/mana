#!/usr/bin/env rails runner

# TODO: use Mechanize
# Bundler.setup(:performance)
# agent = Mechanize.new

Bundler.require(:test)
require 'capybara/dsl'


include Capybara::DSL
Capybara.app_host = 'http://localhost:8080'
Capybara.current_driver = :webkit

10.times do |i|
  name = "Igra #{i}"

  visit '/games'
  click_link 'Create'
  fill_in 'Name', with: "#{name}"
  click_button 'Create Game'

  fill_in 'Cards', with: '15,Forest'
  click_button "Join '#{name}'"
end



