class Notifications < ActionMailer::Base

  QUESTION_RECIPIENTS = %W(bmp7e@virginia.edu)

  def question(email_params, sent_at = Time.now)

    # puts "Sending mail to: #{QUESTION_RECIPIENTS.inspect}"

    mail(:to => QUESTION_RECIPIENTS, :from => email_params[:from],:subject => email_params[:subject])
    # from email_params[:address]
    # sent_on sent_at
    # allows access to @message and @sender_name
    # in view
    # body :message => email_params[:body], :sender_name => email_params[:name]
  end

end
