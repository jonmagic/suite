class Schedule < ActiveRecord::Base
  belongs_to :user
  has_many :sentries
  has_many :notification_queues
  
  validates_presence_of :user_id
  
end
