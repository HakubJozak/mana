Dir[File.expand_path('helpers/*.rb',  File.dirname(__FILE__))].each{|f| require f }

# TODO: don't reload in production
require 'sinatra/reloader'

module Mana
  class Server < Sinatra::Base

    set :app_file, __FILE__
    set :root, File.dirname(__FILE__)
    set :views, 'views'
    set :public, 'public'
    set :sessions, true
    set :mongo, 'mongo://localhost:27017/mana'

    helpers do
      include Haml::Helpers
      include EnvHelper
    end

    configure(:test, :development) do
      register Sinatra::Reloader
      also_reload "app/**/*.rb"
      also_reload "client/**/*.coffee"
      also_reload "views/**/*.*"
    end

    configure(:test) do
      also_reload "test/**/*.rb"
    end

    # configure do
    #   Compass.add_project_configuration(File.join(Mana::StaticServer.root, 'config', 'compass.config'))
    # end

    get '/javascripts/client/:name.js' do
      coffee :"../client/#{params[:name]}", :no_wrap => true
    end

    # TODO: DRY
    get '/javascripts/client/views/:name.js' do
      coffee :"../client/views/#{params[:name]}", :no_wrap => true
    end



    #
    # TODO: replace by SCSS (when the issue with locals is resolved)
    #
    # let it actually do something!
    #
    get '/stylesheets/users/:user_id.css' do
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
      haml :game
    end

    get '/flow' do
      haml :test
    end

    # Routes to server QUnit and test files and styles
    configure :test do

      get '/tests/qunit' do
        @headless = true if params[:headless]
        erb :qunit_test
      end

      get '/tests/integration' do
        @headless = true if params[:headless]
        erb :qunit_test
      end

      get '/tests/:suite/:name.js' do
        coffee File.join('..', 'test', params[:suite], params[:name]).to_sym, :no_wrap => true
      end
    end

    # get '/cards/:name.:format' do
    #   card = MagicCardsInfo.create_card(params[:name])
    #   redirect(params[:format] == 'html' ? card.url : card.image_url)
    # end

  end

end
