class Notifications < ActionMailer::Base

  default :to => %W(bmp7e@virginia.edu)

  def question(email_params, sent_at = Time.now)
    mail(:from => email_params[:from],:subject => email_params[:subject])
  end

end
