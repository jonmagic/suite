class Email < ActiveRecord::Base
  belongs_to :client
  
  validates_uniqueness_of :address
  validates_format_of :address, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => 'is not a valid email address'
  
end
