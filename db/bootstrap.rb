# Setup some clients
sabretech = Client.create(:name => "SabreTech Consulting LLC", :company => 1)
malibutan = Client.create(:name => "Malibu Tan", :company => 1)
malibutanning = Client.create(:name => "Malibu Tanning", :company => 1)
jon = Client.create(:firstname => "Jonathan", :lastname => "Hoyt", :belongs_to => sabretech.id, :note => "Whatever I want it to be...")
sam = Client.create(:firstname => "Sam", :lastname => "Sallows", :belongs_to => sabretech.id)
brad = Client.create(:firstname => "Brad", :lastname => "Cochran", :belongs_to => sabretech.id)

# Setup some client attributes
jon_cell = Phone.create(:client => jon, :context => "Cell", :number => "5176101181")
sam_cell = Phone.create(:client => sam, :context => "Cell", :number => "5176104488")
brad_cell = Phone.create(:client => brad, :context => "Cell", :number => "5176106061")
office_phone = Phone.create(:client => sabretech, :context => "Work", :number => "5174377150")
jon_email = Email.create(:client => jon, :context => "Personal", :address => "jonmagic@gmail.com")
sam_email = Email.create(:client => sam, :context => "Personal", :address => "samsallows@gmail.com")
jon_address = Address.create(:client => jon, :context => "Home", :full_address => "316 west blvd south, elkhart IN 46514")
sabretech_address = Address.create(:client => sabretech, :context => "Work", :full_address => "32 S Howell St. Hillsdale MI 49242")

# Setup some devices
jons_computer = Device.create(:client => jon, :name => "gaming computer", :service_tag => "1234567890")
sams_laptop = Device.create(:client => sam, :name => "macbook", :service_tag => "0987654321")
malibu_workstation = Device.create(:client => malibutan, :name => "hillsdale-master", :service_tag => "")

# Setup some users and roles
technician_role = Role.create(:name => 'technician')
jonmagic = User.find(1)
jonmagic.client_id = 4
jonmagic.name = jon.fullname
jonmagic.save
jonmagic.roles << technician_role
# samtheslacker = User.create do |u|
#   u.email = "samsallows@gmail.com"
#   u.password = u.password_confirmation = "1214bj06"
#   u.client_id = 5
# end
# samtheslacker.register!
# samtheslacker.activate!
# samtheslacker.roles << technician_role
# samtheslacker.update_attributes(:name => sam.fullname)

# Setup some tickets
ticket1 = Ticket.create(:description => "The first ticket in the system", :client => malibutan, :user_id => 1, :active_on => Date.yesterday)
ticket2 = Ticket.create(:description => "Ticket number 2", :client => sabretech, :user_id => 1, :active_on => Date.yesterday)
ticket3 = Ticket.create(:description => "Only dingbats love the rain", :client => jon, :user_id => 1, :active_on => Date.tomorrow)
ticket4 = Ticket.create(:description => "Cooties are for girls", :client => sam, :user_id => 1, :completed_on => Time.now)
ticket5 = Ticket.create(:description => "Make me a sandwich please", :client => malibutan, :user_id => 1, :archived_on => Time.now - 24.hours)

note1 = TicketEntry.create(:ticket => ticket1, :creator_id => jonmagic.id, :entry_type => "Work Done", :time => 60, :billable => true, :note => "this is a note")

# Create some links between tickets and devices
ticket1.devices << jons_computer
ticket1.devices << sams_laptop
ticket2.devices << jons_computer
ticket3.devices << malibu_workstation