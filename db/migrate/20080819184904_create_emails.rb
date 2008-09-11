class CreateEmails < ActiveRecord::Migration
  def self.up
    create_table :emails do |t|
      t.string :context, :null => false, :default => "Work"
      t.string :address
      t.integer :ordinal, :null => false, :default => 0
      t.integer :client_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :emails
  end
end
