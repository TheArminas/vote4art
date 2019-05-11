class CreateJwtBlacklists < ActiveRecord::Migration[6.0]
  def change
    create_table :jwt_blacklists do |t|
      t.string :jti
<<<<<<< HEAD
      t.datetime :exp
<<<<<<< HEAD
=======
>>>>>>> pixel
=======
>>>>>>> 75da571aa71e15d38481203bf9df9aa2e039f1e9

      t.timestamps
    end
    add_index :jwt_blacklists, :jti
  end
end
