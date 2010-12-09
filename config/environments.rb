Thin::Logging.debug = true


if ENV['RACK_ENV'] == 'production'
  Bundler.require(:default)

  ADDRESS = "83.167.232.160"
  STATIC_PORT = 80
  WEBSOCKET_PORT = 90
else
  Bundler.require(:default, :development)
  Debugger.start

  ADDRESS = "0.0.0.0"
  STATIC_PORT = 3000
  WEBSOCKET_PORT = 8080
end
