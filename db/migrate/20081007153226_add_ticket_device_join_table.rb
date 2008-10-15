class AddTicketDeviceJoinTable < ActiveRecord::Migration
  def self.up
    create_table :devices_tickets, :id => false do |t|
      t.integer :ticket_id, :null => false
      t.integer :device_id, :null => false
    end
  end

  def self.down
    drop_table :tickets_devices
  end
end
