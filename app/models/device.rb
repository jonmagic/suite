class Device < ActiveRecord::Base
  belongs_to :client
  has_many :inventory_items
  
  validates_presence_of :name
  
  def client_name
    client = Client.find(self.client_id)
    return client.fullname
  end
  
end
