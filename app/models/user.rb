module Mana
  class User
    include Mana::Commander
    
    attr_accessor :sid
    attr_reader :ws, :name

    def initialize(name, ws)
      @name = name
      @ws = ws
      # @library = Library.new(File.read('decks/eldrazi'))
    end

    def update_library(cards_list)
      @library = Library.new(cards_list) do |card,progress|
        message_to_client(:me, command(:server, 
                                       :operation => :progress, 
                                       :card => card,
                                       :value => progress ))
      end
      
      message_to_client(:me, command(:server,
                                     :operation => :update_library,
                                     :args => @library ))
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
