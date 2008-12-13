class CreateSchedules < ActiveRecord::Migration
  def self.up
    create_table :schedules do |t|
      t.string :name
      t.boolean :active
      t.integer :user_id
      t.string :start_time
      t.string :end_time
      t.integer :backup_id
    end
  end

  def self.down
    drop_table :schedules
  end
end
