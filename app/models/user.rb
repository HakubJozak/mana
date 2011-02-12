module Mana
  class User
    include Mana::Commander
    
    attr_accessor :sid, :library
    attr_reader :ws, :name

    def initialize(ws, options)
      @ws = ws
      @name = options['name']
      @color = options['color']
      update_library(options['cards'])
    end

    def update_library(cards_list)
      @library = Library.new(cards_list)
    end

    def to_hash
      { :name => @name, :id => @sid }
    end
    
    def draw_a_card
      card = @library.draw_a_card
      # @ws.send(encode(command(:server, card)))
    end

    # Scope: :opponents or :all
    #
    def message_to_client(scope, command)
      case scope
      when :all, :me
        @ws.send(encode(command))
      when :opponents
        @ws.send(encode(command)) unless command[:sid] == @sid
      end
    end
  end
end
