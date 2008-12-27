class CreateGoggles < ActiveRecord::Migration
  def self.up
    create_table :goggles do |t|
      t.string :name
      t.string :module
      t.string :script
      t.text :note
    end
    Goggle.create(:name => "I am alive!", :module => "i_am_alive", :script => "last(1.minutes).any_post.have('alive')")
  end

  def self.down
    drop_table :goggles
  end
end
