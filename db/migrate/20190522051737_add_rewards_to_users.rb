class AddRewardsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_rewards, :integer, default: 0
  end
end
