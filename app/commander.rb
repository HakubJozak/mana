module Mana
  module Commander
    
    def encode_command(action, params)
      data = { :action => ActiveSupport::Inflector.camelize(action.to_s) }.merge(params)
      ActiveSupport::JSON.encode(data)
    end

    # Returns command in form of Hash (TODO: make a subclass?)
    # 
    def decode_command(msg)
      ActiveSupport::JSON.decode(msg)
    end

  end
end
