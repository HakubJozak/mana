#!/usr/bin/env ruby

require 'sinatra'
require 'coffee-script'
require 'rack'

ROOT = File.dirname(__FILE__) + '/../..'
TEST_ROOT = File.dirname(__FILE__)

set :public, ROOT + '/public'
set :views,  ROOT + '/views'


use Rack::Static, :urls => ["/qunit"]


get '/' do
  @suites = Dir[ROOT + '/test/client/tests/**/*.coffee'].map do |file|
    puts file
    File.basename(file, '.coffee')
  end

  erb :"../test/client/runner", :layout => false
end

get '/javascripts/:name.js' do
  begin
    coffee :"/coffee/#{params[:name]}", :no_wrap => true
  rescue Errno::ENOENT 
    pass
  end
end

get '/tests/:name.js' do
  coffee :"../test/client/tests/#{params[:name]}", :no_wrap => true
end


get '/suites/:suite.html' do
  @suite = params[:suite]
  haml :"../test/client/#{@suite}", :layout => :'../test/client/layout'
end
