#! /home/jakub/prog/projects/mana/script/rails runner

$:.unshift '.'

require 'web_socket'
require './test/browser'


while true do
  game = Fabricate(:game_with_bad_cards)
  p1 = game.players.first
  b1 = Browser.new(game.id, p1.id, port: 9090).wait_until_connected
  puts '.'
end





# Asserts the action is 'quick' (takes less then 0.01s) with
# tolerance of 0.001s.
#
def assert_quick( action, expected_duration = 0.01, &block)
  start = Time.now.to_f
  yield
  duration = Time.now.to_f - start

  assert (duration - expected_duration) <= 0.001, "Action took #{duration}s but at most #{expected_duration}s was expected."
end
