module Mana
  class StaticServer < Sinatra::Base

    set :app_file, __FILE__
    set :root, File.dirname(__FILE__)
    set :views, "views"
    set :public, 'public'
    set :sessions, true

    helpers do
      include Haml::Helpers

      def box(id)
        haml_tag ".box-container" do
          # TODO: tooltip
          # haml_tag :label, :for => id do
          #   haml_concat id.capitalize + ':'
          #   haml_tag :strong, 0
          # end

          haml_tag :div, :id => id, :class => 'box' do
            yield if block_given?
          end        
        end
      end
    end
    
    configure(:development) do
      register Sinatra::Reloader
      also_reload "app/**/*.rb"
    end

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

    # get '/cards/:name.:format' do
    #   card = MagicCardsInfo.create_card(params[:name])
    #   redirect(params[:format] == 'html' ? card.url : card.image_url)
    # end
    
  end
end
