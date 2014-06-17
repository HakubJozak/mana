require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mana
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # config.autoload_paths += %W(#{config.root}/lib)
    # config.autoload_paths += Dir["#{config.root}/lib/**/"]

    config.log_level = :debug


    # config.assets.enabled = true
    # config.assets.version = '1.0'
    # config.assets.precompile += ['client.js', 'client.css']
    # config.assets.compile = true

    config.sass.cache = false

    # 'config.sass.load_paths' is no longer used while loading SASS libs
    # 'config.assets' is an instance of Sprockets::Environment
    config.assets.paths << "#{Gem.loaded_specs['compass-core'].full_gem_path}/stylesheets"
    config.assets.paths << "#{Gem.loaded_specs['susy'].full_gem_path}/sass"

    require 'mana/backend'
    config.middleware.use Mana::Backend
  end
end
