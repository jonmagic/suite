class RenameFileTable < ActiveRecord::Migration
  def self.up
    rename_table :files, :things
  end

  def self.down
    rename_table :things, :files
  end
end
