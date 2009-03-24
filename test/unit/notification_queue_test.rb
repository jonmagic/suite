require File.dirname(__FILE__) + '/../test_helper'

class NotificationQueueTest < ActiveSupport::TestCase
  should_belong_to :schedule
  
end