# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
require 'factory_bot_rails'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ErogeReleaseDb
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Factory bot generate file path settings
    # test/factories/*.rb -> spec/factories/*.rb
    config.factory_bot.definition_file_paths = ['spec/factories']
  end
end
