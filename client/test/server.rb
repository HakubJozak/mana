#!/usr/bin/env ruby

require 'sinatra'
require 'coffee-script'
require 'rack'

ROOT = File.dirname(__FILE__) + '/../..'
TEST_ROOT = File.dirname(__FILE__)

set :public, ROOT + '/public'
set :views,  TEST_ROOT


use Rack::Static, :urls => ["/qunit"]


get '/' do
  @suites = Dir[TEST_ROOT + '/**/*.coffee'].map do |file|
    puts file
    File.basename(file, '.coffee')
  end

  erb :runner, :layout => false
end

get '/client/:name.js' do
  coffee :"../#{params[:name]}", :no_wrap => true
end

get '/tests/unit/:name.js' do
  coffee :"../test/unit/card_test", :no_wrap => true
end

get '/suites/:suite.html' do
  @suite = params[:suite]
  haml :layout
end
