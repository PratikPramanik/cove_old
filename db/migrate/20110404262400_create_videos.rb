class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string :filename
      t.datetime :added
      t.string :name
      t.string :hash
      t.integer :size
      t.string :origin

      t.timestamps
    end
  end
  
  def self.down
    drop_table :videos
  end
end
