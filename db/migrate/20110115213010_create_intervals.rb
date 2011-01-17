class CreateIntervals < ActiveRecord::Migration
  def self.up
    create_table :intervals do |t|
      t.string :camera_angle

      t.timestamps
    end
  end

  def self.down
    drop_table :intervals
  end
end
