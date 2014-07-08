module Mana
  class Backend
    KEEPALIVE_TIME = 15 # in seconds
    CHANNEL        = "mana"

    def initialize(app)
      @app = app
      @clients = []
#      @thread = Thread.new do
#         begin
#            connection = ActiveRecord::Base.connection_pool.checkout
#            conn = connection.instance_variable_get(:@connection)
#            conn.async_exec "LISTEN cards"
#             # conn.async_exec "LISTEN messages"

#             # This will block until a NOTIFY is issued on one of these two channels.
#             loop do
#               p 'LISTENING'
#               conn.wait_for_notify do |channel, pid, payload|
#                 puts "Received a NOTIFY on channel #{channel}"
#                 puts "from PG backend #{pid}"
#                 puts "saying #{payload}"
# #                @clients.each { |ws| ws.send(payload) }
#               end
#             end

#           rescue => e
#             puts e.message
#           ensure
#             # Don't want the connection to still be listening once we return
#             # it to the pool - could result in weird behavior for the next
#             # thread to check it out.
#             conn.async_exec "UNLISTEN *"
#             ActiveRecord::Base.connection_pool.checkin(connection)
#           end
#       end
    end

    def call(env)
      if Faye::WebSocket.websocket?(env)
        ws = Faye::WebSocket.new(env, nil, {ping: KEEPALIVE_TIME })
        log = Rails.logger

        ws.on :open do |event|
          p [:open, ws.object_id]
          @clients << ws
        end

        ws.on :message do |event|
          begin
            parsed = JSON.parse(event.data).symbolize_keys
            payload = event.data

            if attrs = parsed[:card]
              attrs.symbolize_keys!
              card = Card.find(attrs.delete(:id))
              attrs.slice!(:tapped, :position, :slot, :flipped,
                           :covered, :toughness, :power, :counters)
              attrs[:slot_id] = attrs.delete(:slot)
              card.update_attributes!(attrs)
              log.debug "Saved card changes: #{attrs.inspect}"
            elsif attrs = parsed[:player]
              attrs.symbolize_keys!
              player = Player.find(attrs.delete(:id))
              attrs.slice!(:lives, :poison_counters)
              player.update_attributes!(attrs)
              log.debug "Saved player changes: #{attrs.inspect}"
            elsif attrs = parsed[:message]
              # TODO - inject player_id on the server side
              attrs.symbolize_keys!
              player = Player.find(attrs.delete(:player))
              attrs.slice(:text)
              msg = player.messages.create!(attrs)

              payload = { message: {
                  id: msg.id,
                  text: msg.text,
                  player_id: msg.player.id,
                  game_id: msg.player.game.id
              }}.to_json

              log.debug "Saved message changes: #{attrs.inspect}"
            elsif attrs = parsed[:slot]
              log.debug "Passing slot to the clients: #{attrs.inspect}"
              # there is nothing we have to do - card update of the `slot_id` handles
              # it all on the server side
            else
              log.error "Unknown data received via websocket: #{event.data}"
            end

            @clients.each { |ws| ws.send(payload) }
          rescue => e
            log.error "Failed to save a record: #{attrs.inspect} and #{payload}"
            log.error $!
            log.error $@
          end

          # begin
          #   ActiveRecord::Base.connection_pool.with_connection do |connection|
          #     conn = connection.instance_variable_get(:@connection)
          #     conn.async_exec "NOTIFY cards"
          #     p 'notify succesful'
          #   end
          # rescue
          #   p 'notify failed'
          # end
        end

        ws.on :close do |event|
          p [:close, ws.object_id, event.code, event.reason]
          @clients.delete(ws)
          ws = nil
        end

      else
        @app.call(env)
      end
    end
  end
end
