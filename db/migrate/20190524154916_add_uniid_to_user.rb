class AddUniidToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :uniid, :string, default: 'naujas'
    add_index :users, :uniid
  end
end
