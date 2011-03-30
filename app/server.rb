module Mana
  class Server < Sinatra::Base

    set :app_file, __FILE__
    set :root, File.dirname(__FILE__)
    set :views, "views"
    set :public, 'public'
    set :sessions, true
    set :mongo, 'mongo://localhost:27017/mana'


    helpers do
      include Haml::Helpers
    end

    # configure(:development) do
    #   register Sinatra::Reloader
    #   also_reload "app/**/*.rb"
    # end

    # configure do
    #   Compass.add_project_configuration(File.join(Mana::StaticServer.root, 'config', 'compass.config'))
    # end

    get '/javascripts/client/:name.js' do
      coffee :"../client/#{params[:name]}", :no_wrap => true
    end

    #
    # TODO: replace by SCSS (when the issue with locals is resolved)
    #
    # let it actually do something!
    #
    get '/stylesheets/users/:user_id.css' do
      MongoMapper.connection = mongo
      MongoMapper.database = 'mana'
      # MongoMapper.database.authenticate('{user-name}','{user-password}'

      user = s.find_user(params[:user_id])
      puts user.id

      content_type 'text/css', :charset => 'utf-8'
      @color = 'red'
      erb :'stylesheets/user.css'
    end

    get '/stylesheets/:name.css' do
      content_type 'text/css', :charset => 'utf-8'
      scss :"stylesheets/#{params[:name]}", Compass.sass_engine_options
    end

    get '/games/:name' do
      @game_id = params[:name]
      @scripts = Dir['./client/*.coffee'].map { |f| File.basename(f, '.coffee') }.sort

      # TODO: handle priorities better way
      @scripts.reject! { |s| ['visibility', 'battlefield', 'card_browser'].include?(s) }
      @scripts << 'battlefield' << 'card_browser'
      @scripts.unshift 'visibility'

      haml :game
    end

    get '/flow' do
      haml :test
    end

    # get '/cards/:name.:format' do
    #   card = MagicCardsInfo.create_card(params[:name])
    #   redirect(params[:format] == 'html' ? card.url : card.image_url)
    # end

  end

end
