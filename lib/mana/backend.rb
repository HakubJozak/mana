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
          @clients.each { |ws| ws.send(event.data) }
          parsed = JSON.parse(event.data).symbolize_keys

          if attrs = parsed[:card]
            begin
              log.debug 'Saving card changes'
              attrs.symbolize_keys!
              card = Card.find(attrs.delete(:id))
              attrs.slice!(:tapped, :position, :location, :flipped,
                          :covered, :toughness, :power, :counters)
              card.update_attributes(attrs)
            rescue => e
              log.error e.message
              log.error "Failed to save card: #{attrs.inspect}"
            end
          else
            log.error "Unknown data #{event.data}"
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
