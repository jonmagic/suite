sabretech = Client.new(:name => "SabreTech Consulting LLC", :company => 1)
sabretech.save
malibutan = Client.new(:name => "Malibu Tan", :company => 1)
malibutan.save
malibutanning = Client.new(:name => "Malibu Tanning", :company => 1)
malibutanning.save
jon = Client.new(:firstname => "Jonathan", :lastname => "Hoyt", :belongs_to => sabretech.id, :note => "Whatever I want it to be...")
jon.save
sam = Client.new(:firstname => "Sam", :lastname => "Sallows", :belongs_to => sabretech.id)
sam.save
brad = Client.new(:firstname => "Brad", :lastname => "Cochran", :belongs_to => sabretech.id)
brad.save

jon_cell = Phone.new(:client => jon, :context => "Cell", :number => "5176101181")
jon_cell.save
sam_cell = Phone.new(:client => sam, :context => "Cell", :number => "5176104488")
sam_cell.save
brad_cell = Phone.new(:client => brad, :context => "Cell", :number => "5176106061")
brad_cell.save
office_phone = Phone.new(:client => sabretech, :context => "Work", :number => "5174377150")
office_phone.save

jon_email = Email.new(:client => jon, :context => "Personal", :address => "jonmagic@gmail.com")
jon_email.save
sam_email = Email.new(:client => sam, :context => "Personal", :address => "samsallows@gmail.com")
sam_email.save

jon_address = Address.new(:client => jon, :context => "Home", :full_address => "316 west blvd south elkhart IN 46514")
jon_address.save
sabretech_address = Address.new(:client => sabretech, :context => "Work", :full_address => "32 S Howell St. Hillsdale MI 49242")
sabretech_address.save

jons_computer = Device.new(:client => jon, :name => "gaming computer", :service_tag => "1234567890")
jons_computer.save
sams_laptop = Device.new(:client => sam, :name => "macbook", :service_tag => "0987654321")
sams_laptop.save
malibu_workstation = Device.new(:client => malibutan, :name => "hillsdale-master", :service_tag => "")
malibu_workstation.save

ticket1 = Ticket.new(:description => "The first ticket in the system", :client => malibutan, :user_id => 1, :group => "Service")
ticket1.save