class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.integer :client_id
      t.string :group
      t.integer :user_id
      t.text :description
      t.string :status
      t.date :active

      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end
