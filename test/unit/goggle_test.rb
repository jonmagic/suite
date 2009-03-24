require File.dirname(__FILE__) + '/../test_helper'

class GoggleTest < ActiveSupport::TestCase
  should_have_many :sentries
  
  should_validate_presence_of :name
  should_validate_presence_of :script
  
end