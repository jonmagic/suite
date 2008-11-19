class DeviceType < ActiveRecord::Base
  has_many :devices
  has_and_belongs_to_many :checklist_templates
  
  validates_presence_of :identifier, :description
  
end
