require File.dirname(__FILE__) + '/../test_helper'

class DeviceTypeTest < ActiveSupport::TestCase
  should_have_many :devices
  should_have_and_belong_to_many :checklist_templates
  
  should_validate_presence_of :identifier
  should_validate_presence_of :description
  
end