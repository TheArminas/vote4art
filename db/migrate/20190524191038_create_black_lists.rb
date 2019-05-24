class CreateBlackLists < ActiveRecord::Migration[6.0]
  def change
    create_table :black_lists do |t|
      t.string :ip
      t.string :browser
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :black_lists, :ip
    add_index :black_lists, :browser
  end
end
