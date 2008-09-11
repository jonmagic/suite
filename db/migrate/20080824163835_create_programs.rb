class CreatePrograms < ActiveRecord::Migration
  def self.up
    create_table :programs do |t|
      t.string :name
      t.string :serial_number
      t.integer :device_id

      t.timestamps
    end
  end

  def self.down
    drop_table :programs
  end
end
