class Schedule < ActiveRecord::Base
  belongs_to :user
  has_many :sentries
  
  validates_presence_of :user_id
  
end
