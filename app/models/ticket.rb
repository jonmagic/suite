class Ticket < ActiveRecord::Base
  belongs_to :client
  belongs_to :user
  has_many :ticket_entries
  has_and_belongs_to_many :devices
  has_many :checklists
  has_many :things, :as => :attached, :dependent => :destroy
  
  validates_presence_of :client_id
  validates_presence_of :user_id
  validates_presence_of :description
  
  after_create :add_created_note
  before_update :add_status_change_note
  
  def add_created_note
    TicketEntry.create(:entry_type => "State change", :note => "Ticket created.", :billable => false, :private => true, :detail => 6, :ticket => self, :creator_id => self.creator_id)
  end
  
  def add_status_change_note
    before_update = Ticket.find(self.id)
    after_update = self
    if after_update.status != before_update.status
      TicketEntry.create(:entry_type => "State change", :note => "Status changed to #{after_update.status}", :billable => false, :private => true, :detail => 6, :ticket => self, :creator_id => self.creator_id)
    end
  end
  
  def status
    if self.archived_on != nil
      return "Archived on "+self.archived_on.strftime("%m/%d/%Y")
    elsif self.completed_on != nil
      return "Completed on "+self.completed_on.strftime("%m/%d/%Y")
    elsif self.active_on != nil && self.active_on > Date.today
      return "Scheduled for "+self.active_on.strftime("%m/%d/%Y")
    else
      return "Open"
    end
  end
  
  def technician
    User.find(self.user_id)
  end
  
  def owner
    Client.find(self.client_id)
  end
  
  def self.limit(status, scope, user, device)
    future = Date.today + 100.years
    past = Date.today - 100.years
    if status == nil || status == "open"
      conditions = {:archived_on => nil, :active_on => past..Date.today, :completed_on => nil}
    elsif status == "scheduled"
      conditions = {:archived_on => nil, :active_on => Date.tomorrow..future, :completed_on => nil}
    elsif status == "completed"
      conditions = {:archived_on => nil, :completed_on => past..future}
    elsif status == "archived"
      conditions = {:archived_on => past..future}
    elsif status == "all"
      conditions = {:archived_on => nil}
    end
    if scope == "user" || status == nil
      conditions[:user_id] = user.id
    end
    self.find(:all, :conditions => conditions, :limit => 100)
  end
  
  def self.totals(user)
    future = Date.today + 100.years
    past = Date.today - 100.years
    totals = {}
    open = {:archived_on => nil, :active_on => past..Date.today, :completed_on => nil, :user_id => user.id}
    scheduled = {:archived_on => nil, :active_on => Date.tomorrow..future, :completed_on => nil, :user_id => user.id}
    completed = {:archived_on => nil, :completed_on => past..future, :user_id => user.id}
    all = {:archived_on => nil}
    totals[:open] = (self.find(:all, :conditions => open)).length > 0 ? (self.find(:all, :conditions => open)).length : ""
    totals[:scheduled] = (self.find(:all, :conditions => scheduled)).length
    totals[:completed] = (self.find(:all, :conditions => completed)).length
    totals[:all] = (self.find(:all, :conditions => all)).length
    return totals
  end
  
  def checklists_complete?
    checklists = []
    checklists.concat(self.checklists)
    checklists.concat(self.devices.collect{|device| device.checklists}.flatten)
    complete = 0
    checklists.each do |checklist|
      checklist.complete? ? complete += 0 : complete += 1
    end
    complete == 0
  end
  
end