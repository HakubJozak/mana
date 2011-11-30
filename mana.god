# -*- mode: ruby; tab-width: 2; -*-

rvm_ruby_string = '1.9.2-p290'
port = '9090'

# domain = 'localhost'
# root = '/home/jakub/prog/projects/mana'

domain = 'ec2-176-34-195-147.eu-west-1.compute.amazonaws.com'
root = '/home/ubuntu/mana/current'

God.pid_file_directory = "#{root}/pids"


God.watch do |w|
  w.name = "mana"
  w.interval = 30.seconds
  w.dir = "#{root}/backend"
  w.log = "#{root}/log/backend.log"

  w.behavior(:clean_pid_file)

  w.env = {
    'RACK_ENV' => 'production',
    'BUNDLE_GEMFILE' => "#{root}/Gemfile"
  }

  w.start = "bundle exec ./backend.rb #{domain} #{port}"

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end

  w.restart_if do |restart|
    restart.condition(:memory_usage) do |c|
      c.above = 150.megabytes
      c.times = [3, 5] # 3 out of 5 intervals
    end

    restart.condition(:cpu_usage) do |c|
      c.above = 50.percent
      c.times = 5
    end
  end

  w.lifecycle do |on|
    on.condition(:flapping) do |c|
      c.to_state = [:start, :restart]
      c.times = 1
      c.within = 5.minute
      c.transition = :unmonitored
      c.retry_in = 10.minutes
      c.retry_times = 5
      c.retry_within = 2.hours
    end
  end

end
