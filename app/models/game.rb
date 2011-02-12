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
      @users.each do |remote_user|
        user.message_to_client(:me, server_command(:add_user,remote_user))
      end

      @users << user

      user.sid = @channel.subscribe do |pack|
        # TODO: subclass EM::Channel to do this
        user.message_to_client(pack[:scope], pack[:command])
      end

      broadcast_to(:me, server_command(:update_library, user, :args => user.library ))

      broadcast_to :opponents, server_command(:add_user, user)
    end

    def send_to_opponents(command)
      broadcast_to :opponents, command
    end

    def disconnect(user)
      @users.delete(user)
      @channel.unsubscribe(user.sid)
      broadcast_to :opponents, server_command(:remove_user, user)
    end

    private
    
    # TODO: subclass EM::Channel to do this
    def broadcast_to(scope, command)
      @channel.push(:scope => scope, :command => command)
    end

    def self.create(id)
      @@games[id] = Game.new(id)
    end

    def server_command(operation, user, args = {})
      { :action => 'Server',
        :operation => operation.to_s,
        :sid => user.sid,
        :user => user.to_hash }.merge(args)
    end
    
  end
end
