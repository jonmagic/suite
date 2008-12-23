class CreateSentries < ActiveRecord::Migration
  def self.up
    create_table :sentries do |t|
      t.boolean :state
      t.text :message
      t.integer :device_id
      t.string :parameters
      t.datetime :last_surveyed_at
      t.integer :survey_interval
      t.integer :notifications_to_send
      t.integer :maximum_notify_frequency
      t.integer :notifications_sent
      t.datetime :last_notified_at
      t.integer :schedule_id
      t.integer :goggle_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sentries
  end
end
