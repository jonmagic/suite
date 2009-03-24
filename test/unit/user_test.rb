require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead.
  # Then, you can remove it from this and the functional test.
  include AuthenticatedTestHelper

  context "user#has_role?" do
    setup do
      @user = Factory.create(:user)
      @role = Factory.create(:role, :name => "Technician")
      @user.roles << @role
    end

    should "have a role" do
      assert @user.has_role?("Technician")
    end
  end
  
end
