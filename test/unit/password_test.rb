require File.dirname(__FILE__) + '/../test_helper'

class PasswordTest < ActiveSupport::TestCase
  should_belong_to :user
  
  should_validate_presence_of :email
  should_validate_presence_of :user
  
end