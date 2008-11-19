class CreateChecklists < ActiveRecord::Migration
  def self.up
    create_table :checklists do |t|
      t.integer :checklist_template_id
      t.string :name
      t.integer :ticket_id
      t.integer :device_id
      t.boolean :completed
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :checklists
  end
end
