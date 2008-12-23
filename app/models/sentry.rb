class Sentry < ActiveRecord::Base
  has_many :events, :as => :recordable, :dependent => :destroy
  belongs_to :device
  belongs_to :schedule
  belongs_to :goggle
  
  def survey!
    StatusLang.run(self.id, self.goggle.script) ? true : false
  end
  
  def notify!(message=nil)
    NotificationQueue.create(:message => message, :schedule_id => self.schedule_id)
  end
  
end
