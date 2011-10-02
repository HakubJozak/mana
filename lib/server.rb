Dir[File.expand_path('helpers/*.rb',  File.dirname(__FILE__))].each{|f| require f }

# TODO: don't reload in production


module Mana
  class Server < Sinatra::Base

    set :app_file, __FILE__
    set :root, File.dirname(__FILE__)
    set :views, 'views'
    set :public, 'public'
    set :sessions, true
    set :mongo, 'mongo://localhost:27017/mana'

    # configure(:test) do
    #   also_reload "test/**/*.rb"
    # end

    #
    # TODO: replace by SCSS (when the issue with locals is resolved)
    #
    # let it actually do something!
    #
    # get '/stylesheets/users/:user_id.css' do
    #   content_type 'text/css', :charset => 'utf-8'
    #   @color = 'red'
    #   erb :'stylesheets/user.css'
    # end

    # Routes to server QUnit and test files and styles
    # configure :test do

    #   get '/tests/qunit' do
    #     @headless = true if params[:headless]
    #     erb :qunit_test
    #   end

    #   get '/tests/integration' do
    #     @headless = true if params[:headless]
    #     erb :qunit_test
    #   end

    #   get '/tests/:suite/:name.js' do
    #     coffee File.join('..', 'test', params[:suite], params[:name]).to_sym, :no_wrap => true
    #   end
    #  end

  end

end
