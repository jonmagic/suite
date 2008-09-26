class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.integer :client_id
      t.integer :user_id
      t.text :description
      t.date :active_on
      t.date :completed_on
      t.date :archived_on

      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end
