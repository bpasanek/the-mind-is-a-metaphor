# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true

# See everything in the log (default is :info)
# config.log_level = :debug

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Use a different cache store in production
# config.cache_store = :mem_cache_store

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false

# Enable threaded mode
# config.threadsafe!

MIAM.solr_url = 'http://localhost:8080/metaphors_solr'

ActionMailer::Base.delivery_method = :smtp

# User log rotator
# see http://roninonrails.blogspot.com/2008/04/auto-rotate-rails-log-files.html
config.active_record.colorize_logging = false

log_pipe = IO.popen("/usr/sbin/rotatelogs #{RAILS_ROOT}/log/quandu_staging_log.%Y%m%d 86400", 'a')

config.logger = Logger.new(log_pipe)