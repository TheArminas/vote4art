class AddDefaultColumns < ActiveRecord::Migration[6.0]
  def change
      change_column :users, :pixels_today, :integer, default: 0
      change_column :users, :total_pixels, :integer, default: 0
  end
end
