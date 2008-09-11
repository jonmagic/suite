class CreateDevices < ActiveRecord::Migration
  def self.up
    create_table :devices do |t|
      t.string :name
      t.text :description
      t.string :service_tag
      t.integer :client_id

      t.timestamps
    end
  end

  def self.down
    drop_table :devices
  end
end
