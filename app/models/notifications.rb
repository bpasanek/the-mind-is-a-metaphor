class Notifications < ActionMailer::Base
  
  QUESTION_RECIPIENTS = %W(bmp7e@virginia.edu)
  
  def question(email_params, sent_at = Time.now)
    
    puts "Sending mail to: #{QUESTION_RECIPIENTS.inspect}"
    
    subject "[The Mind is a Metaphor] " << email_params[:subject]
    recipients QUESTION_RECIPIENTS #TODO: change to Brad's before going live
    from email_params[:address]
    sent_on sent_at
    # allows access to @message and @sender_name
    # in view
    body :message => email_params[:body], :sender_name => email_params[:name]
  end

end