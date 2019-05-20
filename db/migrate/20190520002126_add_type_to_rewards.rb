class AddTypeToRewards < ActiveRecord::Migration[6.0]
  def change
    add_column :rewards, :type, :string
    add_index :rewards, :type
  end
end
