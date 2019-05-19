class CreateRewardedUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :rewarded_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :reward, null: false, foreign_key: true

      t.timestamps
    end

    add_index :rewarded_users, [:user_id, :reward_id], unique: true
  end
end
