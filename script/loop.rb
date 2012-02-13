#!/usr/bin/env rails runner

# TODO: use Mechanize
# Bundler.setup(:performance)
# agent = Mechanize.new

Bundler.require(:test)
require 'capybara/dsl'
require 'thread'


include Capybara::DSL
Capybara.app_host = 'http://localhost:8080'
Capybara.current_driver = :webkit

tasks = []

begin
  3.times do |i|
    tasks << fork do
      puts '1'
      name = "Igra Thread #{i}"

      visit '/games'
      puts '2'
      click_link 'Create'
      puts '3'
      fill_in 'Name', with: "#{name}"
      puts '4'
      click_button 'Create Game'
      puts '5'

      fill_in 'Cards', with: '15,Forest'
      click_button "Join '#{name}'"
      puts "Started #{name}"

    50.times do
      sleep rand(4)
      puts "Task #{i}: tapping card"

      # page.execute_script("console.info('something');")
      puts page.evaluate_script('Card.all.first().name()');
      # tap  card
      end
    end
  end
ensure
  tasks.each { |t| Process.waitpid(t) }
end
