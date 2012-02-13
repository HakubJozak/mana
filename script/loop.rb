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

#ready = Queue.new
tasks = []


3.times do |i|
  tasks << fork do
    puts '1'
 #   ready.pop
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
  end
end

tasks.each { |t| Process.waitpid(t) }

#ready.push(true)
# tasks.each { |t| t.join }

