module Mana
  module Commander
    
    def command(action, params)
      data = { :action => action.to_s.upcase }.merge(params)
      ActiveSupport::JSON.encode(data)
    end

    # Returns command in form of Hash (TODO: make a subclass?)
    # 
    def decode(msg)
      ActiveSupport::JSON.decode(msg)
    end

  end
end
