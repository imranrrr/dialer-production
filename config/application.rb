require_relative "boot"

require "rails/all"


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Dialer
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.autoload_paths += %W(#{config.root}/lib)
#     config.web_console.whitelisted_ips = '192.168.5.0/24'
#      config.web_console.whitelisted_ips = ['192.168.1.0/24', '192.168.5.0/24']
#     config.web_console.whitelisted_ips = '192.168.6.0/24'

#Check it
    Dir["./lib/middleware/*.rb"].each do |file|
      p file
      require file
    end

    config.middleware.use RequestLogger, :info
#    config.middleware.use DeltaLogger , :warn
    #Test config array 
    #config.something = %w(zero one two)
    #Application config for groups, ranks, roles used in User model
    config.set = config_for(:config).symbolize_keys
    # Localization
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.default_locale = :uz

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Job adapter
    config.active_job.queue_adapter = ActiveJob::QueueAdapters::AsyncAdapter.new \
      min_threads: 1,
      max_threads: 4 * Concurrent.processor_count,
      idletime: 600.seconds

  end
end
