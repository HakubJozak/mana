module Mana

  class Game
    @@games = {}

    attr_reader :users

    def self.find_or_create(id)
      @@games[id] || create(id)
    end
    
    def initialize(id)
      @id = id
      @users = []
      @channel = EM::Channel.new
    end

    def connect(user)
      user.sid = @channel.subscribe do |pack|
        # TODO: subclass EM::Channel to do this
        user.message_to_client(pack[:scope], pack[:command])
      end

      # add all others to new user
      @users.each do |remote_user|
        args = { :user => remote_user.to_hash(:include_library => true) }
        user.message_to_client(:all, server_command(:add_user,remote_user, :args => args ))
      end

      # add new user to new user
      # TODO: replace :local with requestID
      args = { :user => user.to_hash(:include_library => true), :local => true  };
      user.message_to_client(:me, server_command(:add_user, user, :args => args))

      # add new user to all others
      @users.each do |remote_user|
        args = { :user => user.to_hash(:include_library => true) };
        remote_user.message_to_client(:opponents, server_command(:add_user, user, :args => args))
      end
      
      @users << user
    end

    def send_to_opponents(command)
      broadcast_to :opponents, command
    end

    def disconnect(user)
      @users.delete(user)
      @channel.unsubscribe(user.sid)
      broadcast_to :opponents, server_command(:remove_user, user, :args => { :user => user.to_hash })
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
