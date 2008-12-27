class CreateNotificationQueues < ActiveRecord::Migration
  def self.up
    create_table :notification_queues do |t|
      t.text :message
      t.integer :schedule_id
      t.string :subject
    end
  end

  def self.down
    drop_table :notification_queues
  end
end
