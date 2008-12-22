class Radcheck < ActiveRecord::Base
  use_db :prefix => "freeradius_"
  set_table_name "radcheck"
  
  belongs_to :client
  
  validates_presence_of :username, :attribute, :value
  validates_uniqueness_of :username

  # this won't work for some reason
  before_create :set_attribute  
  def set_attribute
    self.attribute = "User-Password"
  end
  
end