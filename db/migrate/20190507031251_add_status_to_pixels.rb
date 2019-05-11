class AddStatusToPixels < ActiveRecord::Migration[6.0]
  def change
    add_column :pixels, :status, :integer, default: 0
    add_index :pixels, :status
  end
end
