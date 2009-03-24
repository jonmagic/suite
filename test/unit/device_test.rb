require File.dirname(__FILE__) + '/../test_helper'

class DeviceTest < ActiveSupport::TestCase
  should_belong_to :client
  should_belong_to :device_type
  should_have_and_belong_to_many :tickets
  should_have_many :checklists
  should_have_many :things
  should_have_many :sentries
  
  # should_require_unique_attributes :service_tag
  should_validate_presence_of :client_id
  should_validate_presence_of :device_type_id
  
  context "device#service_tags" do
    should "create a service_tag if service_tag is blank" do
      device = Factory.create(:device, :service_tag => nil)
      assert_not_nil device.service_tag
    end
    should "allow a custom service tag" do
      device = Factory.build(:device, :service_tag => "helloworld")
      assert device.save
    end
    should "require a unique service_tag" do
      device1 = Factory.create(:device, :service_tag => "001")
      device2 = Factory.build(:device, :service_tag => "001")
      assert !device2.save
    end
    should "create sequential service_tags for devices of the same type on the same day" do
      device_type = DeviceType.create(:identifier => "522", :description => "a computer")
      device1 = Device.create(:device_type => device_type, :client => Factory.create(:client))
      device2 = Device.create(:device_type => device_type, :client => Factory.create(:client))
      assert_equal device1.service_tag.split("-")[-1].to_i, device2.service_tag.split("-")[-1].to_i - 1
    end
  end
  
  context "device#checklists" do
    should "create associated checklist" do
      setup_checklist_template_device_type_association
      assert_difference "Checklist.count", 1 do
        laptop = Factory.create(:device, :device_type => @dt)
      end      
    end
  end
  
  context "device#client_name" do
    should "return fullname" do
      device = Factory.create(:device)
      assert_not_nil device.client_name
    end
  end
  
  context "device#to_json" do
    # this will be tested in the controller
  end
  
  
  context "device#health" do
    should "return healthy" do
      device = Factory.create(:device)
      sentry = Factory.create(:sentry, :device => device)
      assert_equal device.healthy?, true
    end
    should "find all in trouble" do
      device = Factory.create(:device)
      sentry = Factory.create(:sentry, :device => device, :state => false)
      assert_equal Device.find_all_in_trouble.length, 1
    end
  end
  
  context "device#identifier" do
    should "return device name" do
      device = Factory.create(:device, :name => "big computer")
      assert_equal device.identifier, "big computer"
    end
    should "return device service_tag" do
      device = Factory.create(:device, :name => nil, :service_tag => "1234")
      assert_equal device.identifier, "1234"
    end    
  end
  
  
  context "device#sma_installer_generation" do
    should "create installer when none exists" do
      dir = RAILS_ROOT+"/lib/sma/devices/1"
      if File.exist?(dir+"/sma_installer.exe")
        File.delete(dir+"/config.yaml")
        File.delete(dir+"/sma.nsi")
        File.delete(dir+"/sma_installer.exe")
        Dir.rmdir(dir)
      end
      device = Factory.create(:device, :id => 1)
      device.generate
      assert File.exist?(dir+"/sma_installer.exe")
    end
    should "return already created file" do
      device = Factory.create(:device, :id => 1)
      start = Time.now
      device.generate
      stop = Time.now
      assert_equal stop - start < 1.second, true
    end
  end
  
  def setup_checklist_template_device_type_association
    @dt = DeviceType.create(:identifier => "001", :description => "laptop")
    ct = Factory.create(:checklist_template)
    ctq1 = Factory.create(:checklist_template_question_string, :checklist_template => ct)
    ctq2 = Factory.create(:checklist_template_question_boolean, :checklist_template => ct)
    ctq3 = Factory.create(:checklist_template_question_integer, :checklist_template => ct)
    ct.device_types << @dt
  end
  
end