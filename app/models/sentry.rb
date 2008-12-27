class Sentry < ActiveRecord::Base
  has_many :events, :as => :recordable, :dependent => :destroy
  belongs_to :device
  belongs_to :schedule
  belongs_to :goggle
  
  def survey!
    StatusLang.run(self.id, self.goggle.script) ? true : false
  end
  
  def notify!(subject, message=nil)
    NotificationMailer.deliver_notification(subject, message, self.schedule)
  end
  
  def to_json(options={})
    super(options.merge(:include => :goggle))
  end
  
end
