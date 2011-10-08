#!/usr/bin/env ruby

$:.unshift(File.expand_path('.'))

require 'rubygems'
require 'bundler'


Bundler.require(:default, :development)


def p(who, msg)
  puts "#{who.to_s}: #{Time.now} - #{msg}"
end



EM.run do

  # Create a channel to push data to, this could be stocks...
  Pipe = EM::Channel.new

  # The server simply subscribes client connections to the channel on connect,
  # and unsubscribes them on disconnect.
  class Server < EM::Connection

    puts '!1: ' + self.class.to_s

    def receive_data(data)
      p :server, data
      Pipe.push data
    end

    def post_init
      puts '!2: ' + self.class.to_s
      @sid = Pipe.subscribe { |m| send_data "#{m.inspect}\n" }
    end

    def unbind
      # Pipe.unsubscribe @sid
      puts "Server: client #{@sid} disconnected"
    end
  end


  EM.start_server( '127.0.0.1', 8000, Server)



  # slow
  EM.connect('127.0.0.1', 8000) do |c|
    c.extend EM::P::LineText2

    def c.receive_line(line)
      puts "Subscriber: #{signature} got #{line}"
    end

    EM.add_periodic_timer(6) {
      p 'slow', 'sending'
      c.send_data('turtle')
    }
  end

  # quick
  EM.connect('127.0.0.1', 8000) do |c|
    c.extend EM::P::LineText2

    puts '!3: ' + self.class.to_s

    def c.receive_line(line)
      puts '!4: ' + self.class.to_s
      puts "Subscriber: #{signature} got #{line}"
    end

    def c.errback
      puts 'err'
    end


    EM.error_handler{ |e|
      puts "Error raised during event loop: #{e.message}"
    }

    timer = EM.add_periodic_timer(1) {
      p 'quick', 'sending'
      if r = c.send_data('fox')
        puts r
      end
    }

    EM.add_timer(3) {
      p 'quick client', 'closing'
      timer.cancel
      c.close_connection
    }
  end

#  EM.stop
end
