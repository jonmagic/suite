class CreateChecklistTemplates < ActiveRecord::Migration
  def self.up
    create_table :checklist_templates do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :checklist_templates
  end
end
