class AdminController < ApplicationController
  
  before_filter :authenticate
  
  private
  def authenticate
    authenticate_or_request_with_http_basic do |id, password| 
      id == 'metadmin' && password == 'm3t@4z'
    end
  end
  
end