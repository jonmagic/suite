require File.dirname(__FILE__) + '/../test_helper'

class EmailTest < ActiveSupport::TestCase
  should_belong_to :client
  
  should_validate_uniqueness_of :address
  
  def setup
    Factory.create(:email)
  end
  
  context "validations" do
    should "accept a valid address" do
      email = Factory.build(:email, :address => "quire@example.com")
      assert email.save
    end
    should "reject an invalid address" do
      email = Factory.build(:email, :address => "qu*)@n1-^")
      assert !email.save
    end
  end
  
end