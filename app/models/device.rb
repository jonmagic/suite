class Device < ActiveRecord::Base
  belongs_to :client
  belongs_to :device_type
  has_and_belongs_to_many :tickets
  has_many :checklists, :dependent => :destroy
  has_many :things, :as => :attached, :dependent => :destroy
  has_many :sentries
  
  validates_uniqueness_of :service_tag
  validates_presence_of :client_id, :device_type_id
  
  before_create :create_service_tag
  after_create :create_checklists
  
  def create_service_tag
    if self.service_tag.blank?
      recent_device = Device.find(:first, :order => 'created_at DESC', :conditions => {:created_at.gt => DateTime.now.beginning_of_day, :created_at.lt => DateTime.now.end_of_day, :device_type_id => self.device_type_id})
      device_type = DeviceType.find(self.device_type_id)
      if recent_device != nil
        service_tag_parts= recent_device.service_tag.split("-")
        if recent_device.created_at < Date.today
          new_machine_number = 1
        else
          new_machine_number = service_tag_parts[-1].to_i + 1
        end
        self.service_tag = "#{device_type.identifier}-#{Time.now.strftime("%m%d%y")}-#{new_machine_number}"
      else
        self.service_tag = "#{device_type.identifier}-#{Time.now.strftime("%m%d%y")}-1"
      end
    end
  end
  
  def create_checklists
    checklists = self.device_type.checklist_templates
    if checklists != nil
      checklists.each do |list|
        Checklist.create(:checklist_template => list, :name => list.name, :device => self, :ticket_id => nil)
      end
    end
  end
  
  def client_name
    client = self.client
    return client.fullname
  end
  
  def ticket_id=(ticket_id)
    return ticket_id
  end
  
  def to_json(options={})
    super(options.merge(:methods => :client_name))
  end
  
  def generate
    sma_dir = RAILS_ROOT+"/lib/sma/"
    devices_dir = sma_dir+"devices/"
    device = self
    if File.exist?(devices_dir+device.id.to_s+"/sma_installer.exe")
      return true
    else
      FileUtils.mkdir(devices_dir+device.id.to_s)
      device_dir = devices_dir+device.id.to_s
      FileUtils.cp sma_dir+"windows/sma.nsi", device_dir
      config = File.new(device_dir+"/config.yaml", "w+")
      config.write '{"device":{"id":'+device.id.to_s+'},"auth":{"username":"'+APP_CONFIG[:event_api_username]+'","password":"'+APP_CONFIG[:event_api_password]+'"},"site":{"url":"'+APP_CONFIG[:site_url]+'"}}'
      config.close
      `#{APP_CONFIG[:nsis_path]}/makensis #{device_dir}/sma.nsi`
      return true
    end
  end
  
end
