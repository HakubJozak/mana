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

    def update_library(options)
      @library = Library.new(options['cards'])
    end

    # Scope: :opponents or :all
    #
    def message_to_client(scope, command)
      case scope
      when :all
        @ws.send(encode(command))
      when :opponents
        @ws.send(encode(command)) unless command[:sid] == @sid
      end
    end
    
  end
end
