class AddValidTillAndValueAndStatusToRewards < ActiveRecord::Migration[6.0]
  def change
    add_column :rewards, :valid_till, :datetime
    add_column :rewards, :value, :integer
    add_index :rewards, :valid_till
    add_index :rewards, :value
  end
end
