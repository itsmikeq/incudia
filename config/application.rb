require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Incudia
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
    
    # turn off warnings triggered by friendly_id
    I18n.enforce_available_locales = false
    
    # Test framework
    config.generators.test_framework false

    config.app_domain = 'somedomain.com'

    config.action_mailer.default_url_options = { host: config.app_domain }
    
    # autoload lib path
    config.autoload_paths += %W(#{config.root}/lib #{config.root}/app/services )
    # Bower asset paths
    root.join('vendor', 'assets', 'bower_components').to_s.tap do |bower_path|
      config.sass.load_paths << bower_path
      config.assets.paths << bower_path
    end
    # Precompile Bootstrap fonts
    config.assets.precompile << %r(bootstrap-sass/assets/fonts/bootstrap/[\w-]+\.(?:eot|svg|ttf|woff)$)
    # Minimum Sass number precision required by bootstrap-sass
    ::Sass::Script::Number.precision = [10, ::Sass::Script::Number.precision].max    # For bower when i switch to it
    # config.assets.precompile << Proc.new { |path|
    #   if path =~ /\.(eot|svg|ttf|woff|otf)\z/
    #     true
    #   end
    # }
    # # Precompile Bootstrap fonts
    # config.assets.precompile << %r(bootstrap-sass/assets/fonts/bootstrap/[\w-]+\.(?:eot|svg|ttf|woff)$)
    # # Minimum Sass number precision required by bootstrap-sass
    # ::Sass::Script::Number.precision = [10, ::Sass::Script::Number.precision].max
    config.middleware.use Rack::Attack

    # Allow access to Incudia API from other domains
    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '/api/*', headers: :any, methods: [:get, :post, :options, :put, :delete]
      end
    end

  end
end
