#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.require(:default)
require 'app/commander'




EventMachine.run do

  include Mana::Commander
  
  @commands = EM::Channel.new

  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080, :debug => true) do |ws|

    ws.onopen do
      sid = @commands.subscribe do |command|
        unless command[:sid] == sid
          msg = ActiveSupport::JSON.encode(command)
          ws.send(msg)
        end
      end

      ws.onmessage do |msg|
        command = decode_command(msg).merge( :sid => sid )
        @commands.push(command)
      end
      
      ws.onclose { @commands.unsubscribe(sid) }

      ws.send(encode_command(:message, :text => "Connected as #{sid}"))
    end
  end

  puts "Server started"
end
