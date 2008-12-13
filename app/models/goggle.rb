class Goggle < ActiveRecord::Base
  has_many :sentries, :dependent => :destroy
  
  validates_presence_of :name, :script
  
end
