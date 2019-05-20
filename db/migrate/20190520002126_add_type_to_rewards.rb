class AddTypeToRewards < ActiveRecord::Migration[6.0]
  def change
    add_column :rewards, :tipas, :string
    add_index :rewards, :tipas
  end
end
