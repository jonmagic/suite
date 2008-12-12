class RenameAttachmentTable < ActiveRecord::Migration
  def self.up
    rename_table :attachments, :files
  end

  def self.down
    rename_table :files, :attachments
  end
end
