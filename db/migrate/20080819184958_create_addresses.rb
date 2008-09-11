class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :context, :null => false, :default => "Work"
      t.string :full_address, :null => false
      t.string :thoroughfare
      t.string :city
      t.string :state
      t.integer :zip
      t.integer :ordinal, :null => false, :default => 0
      t.integer :client_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
