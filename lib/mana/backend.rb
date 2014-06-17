module Mana
  class Backend
    KEEPALIVE_TIME = 15 # in seconds
    CHANNEL        = "mana"

    def initialize(app)
      @app = app
      @clients = []
      i = 0

      Thread.new do

#        redis_sub = Redis.new(host: uri.host, port: uri.port, password: uri.password)
#        redis_sub.subscribe(CHANNEL) do |on|
#          on.message do |channel, msg|
        loop do
          sleep(2)
          puts 'Sending'
          # i += 1
          card =  { position: 1 }
          @clients.each {|ws| ws.send(card.to_json) }
        end
#          end
#        end
      end
   end

    def call(env)
      if Faye::WebSocket.websocket?(env)
        ws = Faye::WebSocket.new(env, nil, {ping: KEEPALIVE_TIME })

        ws.on :open do |event|
          p [:open, ws.object_id]
          @clients << ws
        end

        ws.on :message do |event|
          p [:message, event.data]
#          @redis.publish(CHANNEL, sanitize(event.data))
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
