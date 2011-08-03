# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

# requiring this in the environment doesn't seem to do the job
require 'vendor/plugins/simple_captcha/init.rb'

class ApplicationController < ActionController::Base
  
  include SimpleCaptcha::ControllerHelpers
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  protected
  
  def solr
    MIAM.solr
  end
  
end