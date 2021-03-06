class CreateTicketEntries < ActiveRecord::Migration
  def self.up
    create_table :ticket_entries do |t|
      t.string :entry_type
      t.text :note
      t.integer :time
      t.boolean :billable, :default => true, :null => false
      t.boolean :private, :default => false, :null => false
      t.integer :detail
      t.integer :creator_id
      t.integer :ticket_id

      t.timestamps
    end
  end

  def self.down
    drop_table :ticket_entries
  end
end
