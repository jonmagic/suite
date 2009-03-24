require File.dirname(__FILE__) + '/../test_helper'

class ScheduleTest < ActiveSupport::TestCase
  should_belong_to :user
  should_have_many :sentries
  should_have_many :notification_queues
  
  should_validate_presence_of :user_id
  
end