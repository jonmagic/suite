class AddLaborTypeToTicketEntry < ActiveRecord::Migration
  def self.up
    add_column :ticket_entries, :labor_type, :string
  end

  def self.down
    remove_column :ticket_entries, :labor_type
  end
end
