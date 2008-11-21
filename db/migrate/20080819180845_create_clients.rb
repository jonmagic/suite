class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string  :name
      t.string  :firstname
      t.string  :lastname
      t.boolean :company, :default => 0, :null => false
      t.integer :belongs_to
      t.text    :note
      t.string  :mugshot_file_name
      t.string  :mugshot_content_type
      t.integer :mugshot_file_size
      t.string  :qb_id
      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
