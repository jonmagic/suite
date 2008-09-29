class Email < ActiveRecord::Base
  belongs_to :client
  
  validates_uniqueness_of :address
  
end
