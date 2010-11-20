#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'

Bundler.require

EventMachine.run {
  @commands = EM::Channel.new

  def server_message(text)
    data = { :action => 'MESSAGE', :text => text }
    ActiveSupport::JSON.encode(data)
  end

  
  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080, :debug => true) do |ws|

    ws.onopen do
      sid = @commands.subscribe do |msg|
        ws.send(msg)
      end

      ws.onmessage { |msg|  @commands.push(msg) }
      ws.onclose { @commands.unsubscribe(sid) }

      ws.send(server_message("Connected as #{sid}"))
    end
  end

  puts "Server started"
}
