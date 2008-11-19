class AddChecklistTemplateDeviceTypeJoinTable < ActiveRecord::Migration
  def self.up
    create_table :checklist_templates_device_types, :id => false do |t|
      t.integer :checklist_template_id, :null => false
      t.integer :device_type_id, :null => false
    end
  end

  def self.down
    drop_table :checklist_templates_device_types
  end
end
