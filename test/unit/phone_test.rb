require File.dirname(__FILE__) + '/../test_helper'

class PhoneTest < ActiveSupport::TestCase
  should_belong_to :client
  should_validate_presence_of :number
  
  context "phone#strip_hyphens" do
    should "return only numbers" do
      phone = Factory.create(:phone, :number => "555-555-1212")
      assert_equal phone.number, "5555551212"
    end
    should "never return a hyphen or space" do
      phone = Factory.create(:phone, :number => "555-555---1212   ")
      assert_not_equal phone.number, "555-555---1212   "
    end
  end
  
  
end