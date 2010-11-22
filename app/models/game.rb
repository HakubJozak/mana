module Mana

  class Game
    @@games = {}

    attr_reader :users
    
    # @@redis = Redis.new(:thread_safe=>true)

    def self.find_or_create(id)
      @@games[id] || create(id)
    end
    
    def initialize(id)
      @id = id
      @users = []
      @channel = EM::Channel.new
    end

    def connect(user)
      @users << user
      user.sid = @channel.subscribe do |pack|
        # TODO: subclass EM::Channel to do this
        user.message_to_client(pack[:scope], pack[:command])
      end

      broadcast_to :all, message("User #{user.sid} connected to game #{@id}")
    end

    def received(command)
      broadcast_to :opponents, command
    end

    def disconnect(user)
      @users.delete(user)
      @channel.unsubscribe(user.sid)
    end

    private

    # TODO: subclass EM::Channel to do this
    def broadcast_to(scope, command)
      @channel.push(:scope => scope, :command => command)
    end

    def self.create(id)
      @@games[id] = Game.new(id)
    end

  end
end
