module Mana
  class User
    include Mana::Commander

    attr_accessor :sid, :library
    attr_reader :ws, :name

    alias :id :sid

    def initialize(ws, options)
      @ws = ws
      @name = options['name']
      @color = options['color']
      update_library(options['cards'])
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
