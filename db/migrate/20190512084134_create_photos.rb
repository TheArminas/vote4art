class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
    add_index :photos, :name
    add_index :photos, :url
  end
end
