module Mana
  module Commander

    def message(text)
      command(:message, :text => text)
    end

    def command(action, params)
      { :action => ActiveSupport::Inflector.camelize(action.to_s) }.merge(params)
    end

  end
end
