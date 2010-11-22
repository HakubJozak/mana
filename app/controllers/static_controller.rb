module Mana
  class StaticController < Sinatra::Base
    set :sessions, true
    set :public, File.dirname(__FILE__) + '/../../public'

    get '/stylesheets/:name.css' do
      scss "#{params[:name]}".to_sym
    end

    get '/games/:name' do
      @game_id = params[:name]
      haml :index
    end
  end
end
