module Mana
  module Commander

    def message(text)
      command(:message, :text => text)
    end
    
    def command(action, params)
      { :action => ActiveSupport::Inflector.camelize(action.to_s) }.merge(params)
    end

    def encode(command)
      ActiveSupport::JSON.encode(command)
    end
    
    # Returns command in form of Hash (TODO: make a subclass?)
    #
    def decode(msg)
      ActiveSupport::JSON.decode(msg)
    end

  end
end
