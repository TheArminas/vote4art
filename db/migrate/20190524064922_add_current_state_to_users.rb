class AddCurrentStateToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :current_state, :string
    add_index :users, :current_state
  end
end
