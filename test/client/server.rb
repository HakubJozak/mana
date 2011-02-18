#!/usr/bin/env ruby

require 'sinatra'
require 'coffee-script'
require 'rack'

set :public, File.dirname(__FILE__) + '/../../public'
set :views, File.dirname(__FILE__) + "/../../views"

use Rack::Static, :urls => ["/qunit"]


get '/javascripts/:name.js' do
  coffee :"coffee/#{params[:name]}", :no_wrap => true rescue pass
end

get '/tests/:name.js' do
  coffee :"../test/client/tests/#{params[:name]}", :no_wrap => true
end


get '/suites/:suite.html' do
  @suite = params[:suite]
  erb :"../test/client/#{@suite}"
end

__END__

@@ layout
<!DOCTYPE html>
<html>
<head>
  <title><%= @suite %></title>
  <link rel="stylesheet" href="/qunit/qunit.css" type="text/css" media="screen">
  <script type="text/javascript" src="/qunit/qunit.js"></script>
        <%= yield %> 
</head>
  <body>
    <h1 id="qunit-header">QUnit Test Suite</h1>
    <h2 id="qunit-banner"></h2>
    <div id="qunit-testrunner-toolbar"></div>
    <h2 id="qunit-userAgent"></h2>
    <ol id="qunit-tests"></ol>
    <div id="qunit-fixture">test markup</div>
  </body>
</html>
