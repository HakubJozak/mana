class BackendTestBase < ActionDispatch::IntegrationTest

  def setup
    super
    env = { 'BUNDLE_GEMFILE' => '../Gemfile', 'RACK_ENV' => 'test' }
    cmd = 'bundle exec ruby ./backend.rb localhost 9999'

    @backend = Process.spawn(env, cmd, chdir: './backend', close_others: false)
    puts "Backend PID: #{@backend}"
  end

  def teardown
    puts 'teardown called'
    super
    Process.kill("INT", @backend)
    Process.wait(@backend)
  end

end
