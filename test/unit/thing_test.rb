require File.dirname(__FILE__) + '/../test_helper'

class ThingTest < ActiveSupport::TestCase
  should_belong_to :attached
  
  context "thing#assign_name" do
    should "return true if no name is provided" do
      thing = Factory.build(:thing, :name => nil)
      assert thing.assign_name
    end
    should "return true if a name is provided" do
      thing = Factory.build(:thing, :name => "my fav presentation")
      assert thing.assign_name
    end
  end
  
end