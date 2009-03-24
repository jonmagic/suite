require File.dirname(__FILE__) + '/../test_helper'

class TicketEntryTest < ActiveSupport::TestCase
  should_belong_to :ticket
  
  
end