class AddCreatorIdToTickets < ActiveRecord::Migration
  def self.up
    add_column :tickets, :creator_id, :integer
    Ticket.find(:all).each do |ticket|
      # set to the id of your user
      ticket.update_attributes(:creator_id => 2)
    end
  end

  def self.down
    remove_column :tickets, :creator_id
  end
end
