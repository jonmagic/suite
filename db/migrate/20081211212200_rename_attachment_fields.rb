class RenameAttachmentFields < ActiveRecord::Migration
  def self.up
    rename_column :attachments, :files_id, :attached_id
    rename_column :attachments, :files_type, :attached_type
  end

  def self.down
    rename_column :attachments, :attached_id, :files_id
    rename_column :attachments, :attached_type, :files_type
  end
end
