class CreateRewardedPixels < ActiveRecord::Migration[6.0]
  def change
    create_table :rewarded_pixels do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :count, default: 0

      t.timestamps
    end
    add_index :rewarded_pixels, :count
  end
end
