require File.dirname(__FILE__) + '/../test_helper'

class EventTest < ActiveSupport::TestCase
  should_belong_to :recordable
  def setup
    @event = Factory.create(:event)
  end
  context "event#has" do
    should "return true if it has the word" do
      assert @event.has("hello")
    end
    should "return false if it doesn't have the word" do
      assert !@event.has("pizza")
    end
  end
  
  context "event#to_time" do
    should "convert string to time" do
      event = Factory.create(:event, :data => "Tue Mar 10 10:23:18 EDT 2009")
      assert_instance_of Time, event.to_time
    end
    should "return empty string for data is empty" do
      event = Factory.create(:event, :data => "")
      assert_equal event.to_time, ""
    end
  end
  
  context "event#message" do
    should "return data" do
      assert_equal @event.message, @event.data
    end
  end
  
  
  
  
end