class AddRewNewToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :pix_rew, :integer, default: 0
  end
end
