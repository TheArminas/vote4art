class CreateRewards < ActiveRecord::Migration[6.0]
  def change
    create_table :rewards do |t|
      t.string :lat
      t.string :long
      t.string :hashie

      t.timestamps
    end
  end
end
