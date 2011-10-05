module Mana
  class User
    include Mana::Commander

    attr_accessor :sid, :library
    attr_reader :ws, :name

    alias :id :sid

    def initialize(ws, player)
      @ws = ws
      @name = player.name
      @color = player.color
      update_library(player.deck)
    end

    def update_library(cards)
      @library = Library.new(self, cards)
    end

    def to_hash(opts = {})
      result = { :name => @name, :id => @sid, :color => @color }
      opts[:include_library] ? result.merge(@library) : result
    end

    # Scope: :opponents or :all
    #
    def message_to_client(scope, command)
      case scope
      when :all, :me
        @ws.send(encode(command))
      when :opponents
        @ws.send(encode(command))
#        @ws.send(encode(command)) unless command[:sid] == @sid
      end
    end
  end
end
