require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Bc
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    config.action_view.javascript_expansions[:defaults] = %w(rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    config.active_record.whitelist_attributes = true # Don't get hacked like Github

    def self.require_rating_checks; @@require_rating_checks; end
    def self.require_rating_checks=(obj); @@require_rating_checks = obj; end

  end
end

Bc::Application.require_rating_checks = false

DOMAIN_NAME = 'bettercareguide.org'
SITE_TITLE = "Better Care Guide"
EMAIL_SIG = "Regards, #{SITE_TITLE} Team"
SITE_TAG_LINE = "An open, not for profit feedback system for adult Social Care"
# To generate the obfuscated email run lib/angels/obscure_email.rb
INCOMING_MAIL_PLAIN = 'bettercareguide@reallycare.org'
#INCOMING_MAIL_OBFUSCATED = '&#105;&#110;&#102;&#111;&#0064;&#121;&#111;&#117;&#97;&#110;&#103;&#101;&#108;.&#111;&#114;&#103;'

SITE_NAME = "www.#{DOMAIN_NAME}"
SITE_URL = "http://#{SITE_NAME}"

COMPANY_NAME_PLAIN = 'reallycare CIC'
