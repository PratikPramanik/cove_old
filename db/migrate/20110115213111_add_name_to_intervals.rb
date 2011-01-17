class AddNameToIntervals < ActiveRecord::Migration
  def self.up
    add_column :intervals, :name, :string
  end

  def self.down
    remove_column :intervals, :name
  end
end
