class Command

  def initialize(params)
    @user = params['user']
    # @card = params['command']
  end
  
  def to_json
    JSON.encode(self)
  end
end

module Mana
  class CommandsController < Cramp::Controller::Websocket
    periodic_timer :send_commands, :every => 2
    on_data :receive_command
    on_start :go

    @@storage = []
    
    def go
      puts 'connection detected...'
    end
    
    def receive_command(data)
      params = Rack::Utils.parse_query(data)
      # store(Command.new(params))
      render 'Prdel'
    end

    def send_commands
      @@storage.each do |command|
        render command.to_json
      end
    end

    def respond_with
      [200, {'Content-Type' => 'application/json'}]
    end

    private

    def store(number)
      puts number
      @@storage << Command.new(params)
    end
    
  end
end
