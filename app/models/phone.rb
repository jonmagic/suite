class Phone < ActiveRecord::Base
  belongs_to :client
  validates_presence_of :number
end
