class CreateChecklistItems < ActiveRecord::Migration
  def self.up
    create_table :checklist_items do |t|
      t.integer :checklist_id, :null => false
      t.text :question, :null => false
      t.string :answer_type, :null => false, :default => "string"
      t.binary :binary
      t.boolean :boolean
      t.date :date
      t.datetime :datetime
      t.decimal :decimal
      t.float :float
      t.integer :integer
      t.string :string
      t.text :text
      t.time :time
      t.boolean :completed, :null => false, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :checklist_items
  end
end
