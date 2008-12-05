class AddPartsToTicketEntries < ActiveRecord::Migration
  def self.up
    add_column :ticket_entries, :parts, :string
  end

  def self.down
    remove_column :ticket_entries, :parts
  end
end
