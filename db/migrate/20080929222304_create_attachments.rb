class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.string      :name
      t.text        :description
      t.string      :attachment_file_name
      t.string      :attachment_content_type
      t.integer     :attachment_file_size
      t.integer     :user_id
      t.references  :files, :polymorphic => true
      t.timestamps
    end
  end

  def self.down
    drop_table :attachments
  end
end
