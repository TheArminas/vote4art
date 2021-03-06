class CreatePixels < ActiveRecord::Migration[6.0]
  def change
    create_table :pixels do |t|
      t.string :color
      t.references :user, null: false, foreign_key: true
      t.string :x
      t.string :y

      t.timestamps
    end
  end
end
