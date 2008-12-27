class NotificationMailer < ActionMailer::Base
  
  def notification(subject, message, schedule)
    technician = Client.find(schedule.user.client_id)
    email = Email.find(:first, :conditions => {:client_id => technician.id})
    @recipients = "#{email.address}"
    @from = APP_CONFIG[:admin_email]
    @subject = "#{subject}"
    @sent_on = Time.now
    @body[:message] = message
  end

end