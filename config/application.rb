require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'letter_opener' if Rails.env.development?

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PromoteLiving
  class Application < Rails::Application
    # config.assets.precompile << 'delayed/web/application.css'
    config.i18n.enforce_available_locales = true
    config.active_record.default_timezone = :utc

    config.generators do |generate|
      generate.helper false
      generate.javascript_engine false
      generate.request_specs false
      generate.routing_specs false
      generate.stylesheets false
      generate.test_framework :rspec
      generate.view_specs false
      generate.fixture_replacement :factory_girl
    end

    config.action_controller.action_on_unpermitted_parameters = :raise
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Eastern Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.autoload_paths << Rails.root.join('lib')

    # Needs to be false on Heroku
    config.serve_static_files = false
    config.static_cache_control = "public, max-age=31536000"

    # Add the fonts path
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts', 'vendor')
    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Precompile additional assets
    config.assets.precompile += %w( *.svg *.eot *.woff *.ttf *.png *.jpg *.jpeg *.gif)
  end
end
