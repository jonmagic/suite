class Device < ActiveRecord::Base
  belongs_to :client
  has_and_belongs_to_many :tickets
  
  validates_presence_of :name
  
  def client_name
    client = Client.find(self.client_id)
    return client.fullname
  end
  
end
