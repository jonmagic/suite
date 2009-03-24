require File.dirname(__FILE__) + '/../test_helper'

class AddressTest < ActiveSupport::TestCase
  should_belong_to :client
  
  context "address#normalize_address" do
    should "normalize address before save" do
      address = Factory.create(:address)
      assert_equal "154 Lewis St", address.thoroughfare
    end
    
    should "not normalize because address is already normalized" do
      address = Factory.create(:address, :zip => "49242", :full_address => "154 Lewis St Hillsdale MI 49242")
      assert_not_equal "154 Lewis St", address.thoroughfare
    end
    
    should "fail gracefully for bad address" do
      address = Factory.create(:address, :full_address => "155 hello st bluefield il 55522")
      assert_not_nil address
    end
    
  end
  
  def valid_address_attributes(options={})
    {
      :client_id => 1
    }.merge(options)
  end
  
end