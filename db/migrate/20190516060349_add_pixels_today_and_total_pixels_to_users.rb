class AddPixelsTodayAndTotalPixelsToUsers < ActiveRecord::Migration[6.0]
  def self.up
    add_column :users, :pixels_today, :integer
    add_index :users, :pixels_today
    add_column :users, :total_pixels, :integer
    add_index :users, :total_pixels
  end

  def self.down
    remove_column :users, :pixels_today, :integer
    remove_index :users, :pixels_today
    remove_column :users, :total_pixels, :integer
    remove_index :users, :total_pixels
  end
end
