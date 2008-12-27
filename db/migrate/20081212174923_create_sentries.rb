class CreateSentries < ActiveRecord::Migration
  def self.up
    create_table :sentries do |t|
      t.boolean :state
      t.text :message
      t.integer :device_id
      t.string :parameters
      t.datetime :last_surveyed_at
      t.integer :survey_interval, :default => 5, :null => false
      t.integer :notifications_to_send, :default => 5, :null => false
      t.integer :maximum_notify_frequency, :default => 15, :null => false
      t.integer :notifications_sent, :default => 0, :null => false
      t.integer :schedule_id
      t.integer :goggle_id
      t.timestamps
      t.datetime :last_notified_at
    end
  end

  def self.down
    drop_table :sentries
  end
end
