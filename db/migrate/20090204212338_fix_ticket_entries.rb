class FixTicketEntries < ActiveRecord::Migration
  def self.up
    change_column :ticket_entries, :parts, :text
    add_column :ticket_entries, :drive_time, :integer
  end

  def self.down
    change_column :ticket_entries, :parts, :string
    remove_column :ticket_entries, :drive_time
  end
end
