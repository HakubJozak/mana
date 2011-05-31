module EnvHelper
  def env?(environment)
    ENV['RACK_ENV'].to_sym == environment.to_sym
  end
end