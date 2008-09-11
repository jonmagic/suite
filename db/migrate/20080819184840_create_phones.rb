class CreatePhones < ActiveRecord::Migration
  def self.up
    create_table :phones do |t|
      t.string :context, :null => false, :default => "Work"
      t.string :number
      t.integer :ordinal, :null => false, :default => 0
      t.integer :client_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :phones
  end
end
