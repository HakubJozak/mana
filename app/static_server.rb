module Mana
  class StaticServer < Sinatra::Base

    set :app_file, __FILE__
    set :root, File.dirname(__FILE__)
    set :views, "views"
    set :public, 'public'
    
    set :sessions, true

    # configure(:development) do
    #   register Sinatra::Reloader
    #   also_reload "app/**/*.rb"
    # end

    # configure do
    #   Compass.add_project_configuration(File.join(Mana::StaticServer.root, 'config', 'compass.config'))
    # end

    get '/stylesheets/:name.css' do
      content_type 'text/css', :charset => 'utf-8'
      scss :"stylesheets/#{params[:name]}", Compass.sass_engine_options
    end
    
    get '/games/:name' do
      @game_id = params[:name]
      haml :index
    end

    get '/cards/:name.:format' do
      card = MagicCardsInfo.create_card(params[:name])
      redirect(params[:format] == 'html' ? card.url : card.image_url)
    end
    
  end
end
