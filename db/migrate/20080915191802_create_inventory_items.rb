class CreateInventoryItems < ActiveRecord::Migration
  def self.up
    create_table :inventory_items do |t|
      t.string :type
      t.string :name
      t.text :description
      t.string :serial_number
      t.integer :device_id

      t.timestamps
    end
  end

  def self.down
    drop_table :inventory_items
  end
end
