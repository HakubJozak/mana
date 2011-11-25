# HACK
class EventMachine::WebSocket::Connection
  attr_accessor :table
end


Mongoid.load!("../config/mongoid.yml")


# Signal.trap('HUP') do
#   # TODO: do something sane here - like save all the connection data?
#   puts 'Exiting...'
#   exit!
# end


# TODO -
# require 'em-synchrony-mongodb'
# EM.synchrony do
EM.run do
  # @mongo = Mongo::Connection.new.db('mana')

  EventMachine::WebSocket.start(:host => ADDRESS, :port => WEBSOCKET_PORT, :debug => true) do |ws|

    ws.onerror do |error|
      puts error.backtrace
    end

    ws.onopen do
      ws.request['path'] =~ %r{/games/(\S*)/players/(\S*)}
      game_id = $1
      player_id = $2

      game = Game.find(game_id)
      ws.table = Table.find_or_create(game)
      ws.table.sitdown(player_id, ws)

      puts "Player #{player_id} connected."
    end
  end

  puts "Mana backend started!"
end
