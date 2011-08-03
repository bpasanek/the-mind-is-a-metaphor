# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.11' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :all ]
  
  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'
  
  # activate the solr indexing observer
  config.active_record.observers = :solr_observer
  
  config.gem 'rsolr', :lib=>'rsolr', :version=>'0.12.1'
  config.gem 'rsolr-ext', :lib=>'rsolr-ext', :version=>'0.12.1'
  
  config.gem 'will_paginate', :lib=>'will_paginate', :version=>'2.3.11'
  
  # use HappyMapper for importing the original XML data into the models
  # config.gem 'happymapper', :lib=>'happymapper', :version=>'0.2.5'
  # use Nokogiri for importing the original metaphor XML data.
  # config.gem 'nokogiri', :lib=>'nokogiri', :version=>'1.3.2'
  
  # http://github.com/arydjmal/to_csv/tree/master
  # config.gem 'fastercsv', :version=>'>=1.5'
  config.gem 'rmagick', :lib => 'RMagick' 
  
  # Newrelic RPM
  #config.gem "newrelic_rpm"
  
  
  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
  
end

# Add new inflection rules using the following format 
# (all these examples are active by default):
ActiveSupport::Inflector.inflections do |inflect|
  inflect.plural /^(metaphor_categor)ys$/i, '\1ies'
  inflect.plural /^(categor)ys$/i, '\1ies'
  inflect.plural /^(nationalit)ys$/i, '\1ies'
end

# ActionMailer for email
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address => "",
  :port => 25,
  :domain => "virginia.edu"
}