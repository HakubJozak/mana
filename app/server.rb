#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.require
require 'app/commander'

EventMachine.run do

  include Mana::Commander
  
  @commands = EM::Channel.new

  def command(action, params)
    data = { :action => action.to_s.upcase }.merge(params)
    ActiveSupport::JSON.encode(data)
  end

  # Returns command in form of Hash (TODO: make a subclass?)
  # 
  def decode(msg)
    ActiveSupport::JSON.decode(msg)
  end

  
  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080, :debug => true) do |ws|

    ws.onopen do
      sid = @commands.subscribe do |command|
        unless command[:sid] == sid
          msg = ActiveSupport::JSON.encode(command)
          ws.send(msg)
        end
      end

      ws.onmessage do |msg|
        command = decode(msg).merge( :sid => sid )
        @commands.push(command)
      end
      
      ws.onclose { @commands.unsubscribe(sid) }

      ws.send(command(:message, :text => "Connected as #{sid}"))
    end
  end

  puts "Server started"
end
