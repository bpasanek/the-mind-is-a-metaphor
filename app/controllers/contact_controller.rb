
require 'lib/rfc822'

class ContactController < ApplicationController

  before_filter :set_errors, :only=>[:index,:create]

  def index

  end

  def create
    validate!
    if @errors.empty? and simple_captcha_valid?
      Rails.logger.info 'sending email...'
      Notifications.deliver_question(params)

      redirect_to :action => "thank_you"
    else
      @errors << 'The code entered did not match the image.'
      render :template=>'contact/index'
    end
  end

  def thank_you

  end

  protected

  def validate!
    @errors << 'A Name is required' unless params[:name]=~/\w+/
    @errors << 'A valid Email Address is required' unless params[:address] =~ RFC822::EmailAddress
    @errors << 'A Subject is required' unless params[:subject]=~/\w+/
    @errors << 'A Message is required' unless params[:body]=~/\w+/
  end
  
  def set_errors
    @errors = []
  end
  
end
