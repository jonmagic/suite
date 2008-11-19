class CreateDeviceTypes < ActiveRecord::Migration
  def self.up
    create_table :device_types do |t|
      t.string :description
      t.string :identifier

      t.timestamps
    end
  end

  def self.down
    drop_table :device_types
  end
end
