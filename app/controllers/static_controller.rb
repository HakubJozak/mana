module Mana
  class StaticController < Sinatra::Base
    set :sessions, true
    set :public, File.dirname(__FILE__) + '/../../public'

    get '/:name.css' do
      scss "#{params[:name]}".to_sym
    end
    
    get '/' do
      haml :index
    end
  end
end
