require File.dirname(__FILE__) + '/../test_helper'

class SentryTest < ActiveSupport::TestCase
  should_have_many :events
  should_belong_to :device
  should_belong_to :schedule
  should_belong_to :goggle
  
  context "sentry#survey!" do
    setup do
      @sentry = Factory.create(:sentry)
    end

    should "return false if no event exists" do
      assert !@sentry.survey!
    end
    
    should "return true if event exists" do
      event = Factory.create(:event, :data => "i am alive", :recordable_type => "sentry", :recordable_id => @sentry.id)
      assert @sentry.survey!
    end
  end
  
  context "sentry#notify!" do
    setup do
      @sentry = Factory.create(:sentry)
      @email = Factory.create(:email, :client => @sentry.schedule.user.client)
    end
  
    should "description" do
      assert @sentry.notify!(:subject => "hello world", :message => "sos to the world, i hope that someone sees my")
    end
  end
  
  
  
end