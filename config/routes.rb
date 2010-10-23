def app_routes
  Rack::Builder.new do
    use Rack::Session::Cookie
    
    routes = Usher::Interface.for(:rack) do
      get('/connect').to(CommandsController)
    end

    file_server = Rack::File.new(File.join(File.dirname(__FILE__), '../public/'))

    run Rack::Cascade.new([file_server, routes])
  end
end
