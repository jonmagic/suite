class CreateGoggles < ActiveRecord::Migration
  def self.up
    create_table :goggles do |t|
      t.string :name
      t.string :script
      t.text :note
    end
  end

  def self.down
    drop_table :goggles
  end
end
