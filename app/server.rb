module Mana
  class Server < Sinatra::Base

    set :app_file, __FILE__
    set :root, File.dirname(__FILE__)
    set :views, "views"
    set :public, 'public'
    set :sessions, true

    helpers do
      include Haml::Helpers

      def box(id, has_id = true)
        name = id.split('-').first.capitalize

        haml_tag ".box-container" do
          haml_tag :h4 do
            haml_concat name
            haml_tag "a.browse-button.button", 'Browse' if has_id
          end

          params = if has_id
                     { :id => id, :class => "box" }
                   else
                     { :class => "box #{id}" }
                   end
          
          haml_tag :div, params do
            if block_given?
              yield
            else
              haml_tag '.button-bar' do
                haml_tag 'h4', name
                haml_tag 'a.shuffle-button.button', 'Shuffle'
                haml_tag 'a.uncover-button.button', 'Turn All'
                haml_tag 'a.close-button.button', 'Close'
              end
            end
          end        
        end
      end
    end
    
    # configure(:development) do
    #   register Sinatra::Reloader
    #   also_reload "app/**/*.rb"
    # end

    # configure do
    #   Compass.add_project_configuration(File.join(Mana::StaticServer.root, 'config', 'compass.config'))
    # end

    get '/javascripts/user.js' do
      coffee :'coffee/user'
    end
    
    
    get '/stylesheets/:name.css' do
      content_type 'text/css', :charset => 'utf-8'
      scss :"stylesheets/#{params[:name]}", Compass.sass_engine_options
    end
    
    get '/games/:name' do
      @game_id = params[:name]
      haml :index
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
