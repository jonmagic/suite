class Phone < ActiveRecord::Base
  belongs_to :client
  validates_presence_of :number
  before_save :strip_hyphens
  
  def strip_hyphens
    self.number.gsub!(/-/, "")
  end
end
